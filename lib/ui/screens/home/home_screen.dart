import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/repositories/current_condition_repository.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/current_condition_gauge_chart.dart';
import 'package:mimemo/ui/screens/home/widgets/home_current_conditions.dart';
import 'package:mimemo/ui/screens/home/widgets/home_daily_forecast.dart';
import 'package:mimemo/ui/screens/home/widgets/home_hourly_forecast.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

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

    return BlocSelector<MainCubit, MainState, PositionInfo?>(
      builder: (context, positionInfo) {
        final position = positionInfo?.localizedName ?? '';
        final city =
            positionInfo?.parentCity?.localizedName != null
                ? ', ${positionInfo?.parentCity?.localizedName!}'
                : '';
        return Scaffold(
          appBar: _buildAppBar(position, city),
          drawer: Container(),
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
      },
      selector: (state) => state.positionInfo,
    );
  }

  AppBar _buildAppBar(String position, String city) {
    return AppBar(
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on, color: Colors.white, size: 20),
          const Gap(4),
          Text(
            '$position$city',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
