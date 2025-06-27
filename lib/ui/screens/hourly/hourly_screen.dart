import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/models/enums/load_status.dart';

import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:mimemo/ui/screens/hourly/widgets/hourly_list.dart';

class HourlyScreen extends StatefulWidget {
  const HourlyScreen({super.key});

  @override
  State<HourlyScreen> createState() => _HourlyScreenState();
}

class _HourlyScreenState extends State<HourlyScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<HourlyCubit, HourlyState, LoadStatus>(
      builder: (context, loadStatus) {
        if (loadStatus == LoadStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (loadStatus == LoadStatus.failure) {
          return const SizedBox();
        } else {
          return Scaffold(
            backgroundColor: AppColors.primary,
            body: RefreshIndicator(
              onRefresh: () => context.read<HourlyCubit>().refresh(),
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  _buildAppBar(),
                  // _buildForecastChart(),
                  const SliverToBoxAdapter(child: HourlyList()),
                ],
              ),
            ),
          );
        }
      },
      selector: (state) => state.loadStatus,
    );
  }

  Widget _buildAppBar() {
    return BlocSelector<HourlyCubit, HourlyState, String>(
      selector: (state) => state.currentDay,
      builder: (context, currentDay) {
        return SliverAppBar(
          title: Text(currentDay),
          backgroundColor: AppColors.primary,
          pinned: true,
          surfaceTintColor: AppColors.primary,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(color: Colors.white54, height: 0.5),
          ),
        );
      },
    );
  }

  // Widget _buildForecastChart() {
  //   return SliverToBoxAdapter(
  //     child: BlocBuilder<HourlyCubit, HourlyState>(
  //       builder: (context, state) {
  //         final forecasts = state.hourlyForecasts;
  //         return SizedBox(height: 400, child: HourlyChart(forecasts: forecasts));
  //       },
  //     ),
  //   );
  // }

  @override
  bool get wantKeepAlive => true;
}
