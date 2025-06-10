import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/repositories/current_condition_repository.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/current_condition_gauge_chart.dart';
import 'package:mimemo/ui/screens/home/widgets/home_daily_forecast.dart';
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

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CurrentConditionGaugeChart(),
                        const Gap(24),
                        _buildHourlyPreview(),
                        const Gap(24),
                        _buildWeatherDetails(),
                        const Gap(24),
                        const HomeDailyForecast(),
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
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyPreview() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return previous.next12HoursForecast != current.next12HoursForecast ||
            previous.next12HoursForecastStatus != current.next12HoursForecastStatus;
      },
      builder: (context, state) {
        final next12HoursForecast = state.next12HoursForecast;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
                  ),
                ),
              ],
            ),
            const Gap(16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: next12HoursForecast.length,
                itemBuilder: (context, index) {
                  final forecast = next12HoursForecast[index];
                  final dateTime = DateTime.tryParse(forecast.dateTime ?? '')?.toLocal();
                  final displayTime =
                      dateTime != null ? dateTime.toFormatedString(DateFormatPattern.hour12) : '';
                  final tem = forecast.temperature?.value?.toString() ?? '';
                  final unit = forecast.temperature?.unit ?? '';
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          displayTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: AppIcon(
                            icon: Utils.getIconAsset(forecast.weatherIcon ?? 0),
                            size: 32,
                          ),
                        ),
                        Text(
                          '$tem °$unit',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWeatherDetails() {
    final current = WeatherData.currentConditions;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weather Details',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Humidity',
                  '${current['RelativeHumidity']}%',
                  Icons.water_drop,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  'Wind Speed',
                  '${current['Wind']['Speed']['Imperial']['Value']} mph',
                  Icons.air,
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'UV Index',
                  '${current['UVIndex']} (${current['UVIndexText']})',
                  Icons.wb_sunny,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  'Visibility',
                  '${current['Visibility']['Imperial']['Value']} mi',
                  Icons.visibility,
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Pressure',
                  '${current['Pressure']['Imperial']['Value']} inHg',
                  Icons.speed,
                ),
              ),
              Expanded(
                child: _buildDetailItem('Cloud Cover', '${current['CloudCover']}%', Icons.cloud),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 20),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
