import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/climo_summary/climo_summary.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';

class SelectedDayDetail extends StatefulWidget {
  const SelectedDayDetail({super.key});

  @override
  State<SelectedDayDetail> createState() => _SelectedDayDetailState();
}

class _SelectedDayDetailState extends State<SelectedDayDetail> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_onTabChanged)
      ..dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    if (_selectedTab != _tabController.index) {
      setState(() {
        _selectedTab = _tabController.index;
      });
    }
  }

  void _onTabBarTap(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyCubit, DailyState>(
      buildWhen: (previous, current) =>
          previous.selectedDay != current.selectedDay ||
          previous.selectedDayClimo != current.selectedDayClimo,
      builder: (context, state) {
        final selectedDay = state.selectedDay;
        if (selectedDay == null) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverList(
          delegate: SliverChildListDelegate([
            _buildTabBar(),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _selectedTab != 2
                  ? _buildWeatherContent(context, selectedDay)
                  : _buildHistorical(selectedDay, state.selectedDayClimo),
            ),
          ]),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      onTap: _onTabBarTap,
      dividerColor: AppColors.surface,
      indicatorColor: AppColors.surface,
      labelColor: AppColors.surface,
      labelStyle: context.textTheme.bodyMedium?.w700.copyWith(color: AppColors.surface),
      unselectedLabelColor: Colors.black54,
      unselectedLabelStyle: context.textTheme.bodyMedium?.copyWith(color: Colors.black54),
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
      tabAlignment: TabAlignment.center,
      overlayColor: WidgetStatePropertyAll(AppColors.surface.withValues(alpha: 0.2)),
      controller: _tabController,
      dividerHeight: 0.5,
      tabs: const [
        Tab(
          child: SizedBox(width: 60, child: Center(child: Text('Day'))),
        ),
        Tab(
          child: SizedBox(width: 60, child: Center(child: Text('Night'))),
        ),
        Tab(
          child: SizedBox(width: 60, child: Center(child: Text('History'))),
        ),
      ],
    );
  }

  Widget _buildWeatherContent(BuildContext context, ForecastDay selectedDay) {
    final isDay = _selectedTab == 0;
    final dayNight = isDay ? selectedDay.day : selectedDay.night;

    // Pre-calculate all values to avoid repeated computations
    final temperatureHigh = selectedDay.temperature?.maximum?.value?.toStringAsFixed(0) ?? '';
    final temperatureLow = selectedDay.temperature?.minimum?.value?.toStringAsFixed(0) ?? '';
    final humidity = dayNight?.relativeHumidity?.average?.toString() ?? '';
    final longPhrase = (isDay ? selectedDay.day?.longPhrase : selectedDay.night?.longPhrase) ?? '';

    final realFeelHigh = selectedDay.realFeelTemperature?.maximum?.value?.toStringAsFixed(0) ?? '';
    final realFeelLow = selectedDay.realFeelTemperature?.minimum?.value?.toStringAsFixed(0) ?? '';
    final realFeelShadeHigh =
        selectedDay.realFeelTemperatureShade?.maximum?.value?.toStringAsFixed(0) ?? '';
    final realFeelShadeLow =
        selectedDay.realFeelTemperatureShade?.minimum?.value?.toStringAsFixed(0) ?? '';

    final uvIndex = selectedDay.airAndPollen?.firstWhereOrNull(
      (element) => element.name == 'UVIndex',
    );
    final uvIndexValue = uvIndex?.value?.toString();
    final uvIndexCategory = uvIndex?.category;

    final windSpeed = dayNight?.wind?.speed?.value;
    final windSpeedUnit = dayNight?.wind?.speed?.unit;
    final windDirection = dayNight?.wind?.direction?.localized;

    final windGustSpeed = dayNight?.windGust?.speed?.value;
    final windGustSpeedUnit = dayNight?.windGust?.speed?.unit;

    final rainProbability = dayNight?.rainProbability ?? 0;
    final snowProbability = dayNight?.snowProbability ?? 0;
    final iceProbability = dayNight?.iceProbability ?? 0;
    final cloudCover = dayNight?.cloudCover;

    // Calculate sun and moon times once
    final (sunTimeHours, sunTimeMinutes, sunRiseTime, sunSetTime) = _calculateSunTimes(selectedDay);
    final (moonTimeHours, moonTimeMinutes, moonRiseTime, moonSetTime) = _calculateMoonTimes(
      selectedDay,
    );

    return Column(
      children: [
        _buildTemperatureHeader(
          context,
          selectedDay,
          isDay ? temperatureHigh : temperatureLow,
          isDay ? 'High' : 'Low',
          isDay,
        ),
        const Gap(8),
        _buildHumidityRow(context, humidity),
        const Gap(8),
        _buildDescription(context, longPhrase),
        const Gap(16),
        ..._buildWeatherMetrics(
          _getMetricsForTab(
            isDay,
            realFeelHigh,
            realFeelLow,
            realFeelShadeHigh,
            realFeelShadeLow,
            uvIndexValue,
            uvIndexCategory,
            windSpeed,
            windDirection,
            windSpeedUnit,
            windGustSpeed,
            windGustSpeedUnit,
            rainProbability,
            snowProbability,
            iceProbability,
            cloudCover,
          ),
        ),
        const Gap(24),
        _buildSunMoonInfo(
          context,
          sunTimeHours,
          sunTimeMinutes,
          sunRiseTime,
          sunSetTime,
          moonTimeHours,
          moonTimeMinutes,
          moonRiseTime,
          moonSetTime,
        ),
      ],
    );
  }

  (String, String, String, String) _calculateSunTimes(ForecastDay selectedDay) {
    final sunSet = selectedDay.sun?.set?.toDefaultDate;
    final sunRise = selectedDay.sun?.rise?.toDefaultDate;
    final sunSetTime = sunSet?.toFormatedString(DateFormatPattern.time) ?? '';
    final sunRiseTime = sunRise?.toFormatedString(DateFormatPattern.time) ?? '';
    final sunTime = (sunSet != null && sunRise != null) ? sunSet.difference(sunRise) : null;
    final sunTimeHours = sunTime?.inHours.toString() ?? '';
    final sunTimeMinutes = sunTime?.inMinutes.remainder(60).toString() ?? '';
    return (sunTimeHours, sunTimeMinutes, sunRiseTime, sunSetTime);
  }

  (String, String, String, String) _calculateMoonTimes(ForecastDay selectedDay) {
    final moonSet = selectedDay.moon?.set?.toDefaultDate;
    final moonRise = selectedDay.moon?.rise?.toDefaultDate;
    final moonSetTime = moonSet?.toFormatedString(DateFormatPattern.time) ?? '';
    final moonRiseTime = moonRise?.toFormatedString(DateFormatPattern.time) ?? '';
    final moonTime = (moonSet != null && moonRise != null) ? moonSet.difference(moonRise) : null;
    final moonTimeHours = moonTime?.inHours.toString() ?? '';
    final moonTimeMinutes = moonTime?.inMinutes.remainder(60).toString() ?? '';
    return (moonTimeHours, moonTimeMinutes, moonRiseTime, moonSetTime);
  }

  List<(String, String)> _getMetricsForTab(
    bool isDay,
    String realFeelHigh,
    String realFeelLow,
    String realFeelShadeHigh,
    String realFeelShadeLow,
    String? uvIndexValue,
    String? uvIndexCategory,
    double? windSpeed,
    String? windDirection,
    String? windSpeedUnit,
    double? windGustSpeed,
    String? windGustSpeedUnit,
    int rainProbability,
    int snowProbability,
    int iceProbability,
    int? cloudCover,
  ) {
    final metrics = <(String, String)>[];

    if (isDay) {
      if (realFeelHigh.isNotEmpty) {
        metrics.add(('RealFeel High', '$realFeelHigh${CommonCharacters.degreeChar}'));
      }
      if (realFeelShadeHigh.isNotEmpty) {
        metrics.add(('RealFeel Shade High', '$realFeelShadeHigh${CommonCharacters.degreeChar}'));
      }
      if (uvIndexValue != null && uvIndexCategory != null) {
        metrics.add(('UV Index', '$uvIndexValue ($uvIndexCategory)'));
      }
    } else {
      if (realFeelLow.isNotEmpty) {
        metrics.add(('RealFeel Low', '$realFeelLow${CommonCharacters.degreeChar}'));
      }
      if (realFeelShadeLow.isNotEmpty) {
        metrics.add(('RealFeel Shade Low', '$realFeelShadeLow${CommonCharacters.degreeChar}'));
      }
    }

    // Common metrics for both day and night
    if (windSpeed != null && windDirection != null && windSpeedUnit != null) {
      metrics.add(('Wind', '$windDirection $windSpeed $windSpeedUnit'));
    }
    if (windGustSpeed != null && windGustSpeedUnit != null) {
      metrics.add(('Wind gust', '$windGustSpeed $windGustSpeedUnit'));
    }
    if (rainProbability > 0) {
      metrics.add(('Rain probability', '$rainProbability%'));
    }
    if (snowProbability > 0) {
      metrics.add(('Snow probability', '$snowProbability%'));
    }
    if (iceProbability > 0) {
      metrics.add(('Ice probability', '$iceProbability%'));
    }
    if (cloudCover != null) {
      metrics.add(('Cloud cover', '$cloudCover%'));
    }

    return metrics;
  }

  Widget _buildHistorical(ForecastDay selectedDay, ClimoSummary? climo) {
    final historicalData = [
      (
        "Today's Forecast",
        selectedDay.temperature?.maximum?.value?.toStringAsFixed(0) ?? '',
        selectedDay.temperature?.minimum?.value?.toStringAsFixed(0) ?? '',
      ),
      (
        'Historical Average',
        climo?.normal?.normals?.temperatures?.maximum?.metric?.value?.toStringAsFixed(0) ?? '',
        climo?.normal?.normals?.temperatures?.minimum?.metric?.value?.toStringAsFixed(0) ?? '',
      ),
      (
        'Last Year on this Date',
        climo?.actual?.actuals?.temperatures?.maximum?.metric?.value?.toStringAsFixed(0) ?? '',
        climo?.actual?.actuals?.temperatures?.minimum?.metric?.value?.toStringAsFixed(0) ?? '',
      ),
    ];

    return Column(
      spacing: 16,
      children: [
        _buildHistoricalHeader(),
        ...historicalData.map((data) => _buildHistoricalRow(data.$1, data.$2, data.$3)),
      ],
    );
  }

  Widget _buildHistoricalHeader() {
    return Row(
      children: [
        const Expanded(flex: 14, child: SizedBox()),
        Expanded(
          flex: 3,
          child: Text('High', style: context.textTheme.labelMedium?.copyWith(color: Colors.black)),
        ),
        Expanded(
          flex: 3,
          child: Text('Low', style: context.textTheme.labelMedium?.copyWith(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _buildHistoricalRow(String label, String high, String low) {
    return Row(
      children: [
        Expanded(
          flex: 14,
          child: Text(label, style: context.textTheme.bodyMedium?.copyWith(color: Colors.black)),
        ),
        Expanded(
          flex: 3,
          child: Text(
            high + CommonCharacters.degreeChar,
            style: context.textTheme.bodyMedium?.w600.copyWith(color: Colors.black),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            low + CommonCharacters.degreeChar,
            style: context.textTheme.bodyMedium?.w600.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildTemperatureHeader(
    BuildContext context,
    ForecastDay selectedDay,
    String temperature,
    String label,
    bool isDay,
  ) {
    final iconData = isDay ? selectedDay.day?.icon : selectedDay.night?.icon;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(icon: Utils.getIconAsset(iconData ?? 0), size: 54),
        Text(
          temperature,
          style: context.textTheme.displayMedium?.w700.copyWith(color: Colors.black),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              CommonCharacters.degreeChar,
              style: context.textTheme.displayMedium?.w700.copyWith(color: Colors.black),
            ),
            Text(label, style: context.textTheme.bodyMedium?.copyWith(color: Colors.black)),
          ],
        ),
      ],
    );
  }

  Widget _buildHumidityRow(BuildContext context, String humidity) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.water_drop_outlined, color: Colors.black, size: 14),
        Text(
          'Humidity: $humidity%',
          style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, String longPhrase) {
    return Text(
      ' $longPhrase',
      style: context.textTheme.bodyMedium?.copyWith(color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  List<Widget> _buildWeatherMetrics(List<(String, String)> metrics) {
    return metrics.map((metric) => _buildInfoRow(metric.$1, metric.$2)).toList();
  }

  Widget _buildSunMoonInfo(
    BuildContext context,
    String sunTimeHours,
    String sunTimeMinutes,
    String sunRiseTime,
    String sunSetTime,
    String moonTimeHours,
    String moonTimeMinutes,
    String moonRiseTime,
    String moonSetTime,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _buildSunMoonSection(
                context,
                Icons.sunny,
                AppColors.orange,
                sunTimeHours,
                sunTimeMinutes,
                sunRiseTime,
                sunSetTime,
              ),
            ),
            const VerticalDivider(color: Colors.black12, width: 32),
            Expanded(
              child: _buildSunMoonSection(
                context,
                Icons.nightlight,
                AppColors.blue,
                moonTimeHours,
                moonTimeMinutes,
                moonRiseTime,
                moonSetTime,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSunMoonSection(
    BuildContext context,
    IconData icon,
    Color iconColor,
    String hours,
    String minutes,
    String riseTime,
    String setTime,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: iconColor),
            Text(
              '$hours hours\n$minutes minutes',
              style: context.textTheme.bodySmall?.w500.copyWith(color: Colors.black),
            ),
          ],
        ),
        const Gap(8),
        _buildInfoRow('Rise', riseTime, bottomBorder: false),
        _buildInfoRow('Set', setTime, bottomBorder: false),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool bottomBorder = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: bottomBorder
            ? const Border(bottom: BorderSide(color: Colors.black12))
            : const Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        spacing: 8,
        children: [
          Text(label, style: context.textTheme.bodySmall?.copyWith(color: Colors.black)),
          Expanded(
            child: Text(
              value,
              style: context.textTheme.bodyMedium?.w500.copyWith(color: Colors.black),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
