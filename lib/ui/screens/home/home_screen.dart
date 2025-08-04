import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/current_condition_gauge_chart.dart';
import 'package:mimemo/ui/screens/home/widgets/home_current_conditions.dart';
import 'package:mimemo/ui/screens/home/widgets/home_daily_forecast.dart';
import 'package:mimemo/ui/screens/home/widgets/home_hourly_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.surface),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => _cubit.init(),
            child: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 24,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CurrentConditionGaugeChart(),
                    HomeCurrentConditions(),
                    HomeHourlyForecast(),
                    HomeDailyForecast(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
