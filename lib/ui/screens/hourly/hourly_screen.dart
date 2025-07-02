import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/core/const/consts.dart';
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
  final BottomSheetBarController _bottomSheetBarController =
      BottomSheetBarController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<HourlyCubit, HourlyState, LoadStatus>(
      selector: (state) => state.loadStatus,
      builder: (context, loadStatus) {
        return Scaffold(
          backgroundColor: AppColors.primary,
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
    return RefreshIndicator(
      onRefresh: () => context.read<HourlyCubit>().refresh(),
      child: BottomSheetBar(
        controller: _bottomSheetBarController,
        header: const SizedBox(),
        body: HourlyList(
          onItemTap: _bottomSheetBarController.expand,
        ),
        expandedWidget: const SelectedHourDetail(),
        bodyBottomPadding: 0,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
