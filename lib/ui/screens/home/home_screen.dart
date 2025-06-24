import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/repositories/current_condition_repository.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/current_condition_gauge_chart.dart';
import 'package:mimemo/ui/screens/home/widgets/home_current_conditions.dart';
import 'package:mimemo/ui/screens/home/widgets/home_daily_forecast.dart';
import 'package:mimemo/ui/screens/home/widgets/home_hourly_forecast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => HomeCubit(
            forecastRepository: locator<ForecastRepository>(),
            mainCubit: context.read<MainCubit>(),
            currentConditionRepository: locator<CurrentConditionRepository>(),
          ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
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
        decoration: const BoxDecoration(color: AppColors.primary),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {},
            child: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 24,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CurrentConditionGaugeChart(),
                    HomeHourlyForecast(),
                    HomeCurrentConditions(),
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
