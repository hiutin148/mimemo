import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:mimemo/ui/screens/hourly/widgets/hourly_list.dart';
import 'package:mimemo/ui/screens/hourly/widgets/selected_hour_detail.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class HourlyScreen extends StatefulWidget {
  const HourlyScreen({super.key});

  @override
  State<HourlyScreen> createState() => _HourlyScreenState();
}

class _HourlyScreenState extends State<HourlyScreen>
    with AutomaticKeepAliveClientMixin {
  late final BottomSheetBarController _bottomSheetBarController;

  @override
  void initState() {
    super.initState();
    _bottomSheetBarController = BottomSheetBarController()..minSize = 0;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<HourlyCubit, HourlyState, LoadStatus>(
      selector: (state) => state.loadStatus,
      builder: (context, loadStatus) {
        return Scaffold(
          backgroundColor: AppColors.surface,
          body: _buildBody(context, loadStatus),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, LoadStatus loadStatus) {
    return switch (loadStatus) {
      LoadStatus.loading => const Center(child: CircularProgressIndicator()),
      LoadStatus.failure => _buildErrorState(context),
      _ => _buildSuccessState(context),
    };
  }

  Widget _buildErrorState(BuildContext context) {
    return LoadErrorWidget(
      onRetry: () => context.read<HourlyCubit>().refresh(),
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    return BlocListener<HourlyCubit, HourlyState>(
      listenWhen: (previous, current) =>
          previous.selectedForecast != current.selectedForecast,
      listener: (BuildContext context, HourlyState state) {
        _bottomSheetBarController.expand();
      },
      child: RefreshIndicator(
        onRefresh: () => context.read<HourlyCubit>().refresh(),
        child: BottomSheetBar(
          controller: _bottomSheetBarController,
          header: _buildBottomSheetHeader(context),
          body: HourlyList(
            onItemTap: (forecast) =>
                context.read<HourlyCubit>().selectForecast(forecast),
          ),
          expandedBuilder: (context, scrollController) =>
              const SelectedHourDetail(),
          bodyBottomPadding: 0,
        ),
      ),
    );
  }

  Widget _buildBottomSheetHeader(BuildContext context) {
    return BlocSelector<HourlyCubit, HourlyState, HourlyForecast?>(
      builder: (context, selectedDay) {
        final time =
            selectedDay?.dateTime?.reformatDateString(
              newFormat: DateFormatPattern.time,
            ) ??
            '';
        final weekday =
            selectedDay?.dateTime?.reformatDateString(
              newFormat: DateFormatPattern.dayOfWeek,
            ) ??
            '';
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: AppColors.blackBorderColor),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '$time, $weekday',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      selector: (state) => state.selectedForecast,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
