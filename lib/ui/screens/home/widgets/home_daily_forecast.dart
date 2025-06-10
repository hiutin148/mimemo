import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_cubit.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class HomeDailyForecast extends StatelessWidget {
  const HomeDailyForecast({super.key});

  static const _borderRadius = 16.0;
  static const _padding = 16.0;
  static const _iconSize = 16.0;

  void _onViewAllTapped(BuildContext context) {
    context.read<BottomNavCubit>().switchTab(1);
  }

  void _onForecastItemTapped(BuildContext context, dynamic forecastDay, int index) {
    // Handle individual forecast item tap
    // Navigator.of(context).pushNamed('/forecast-detail', arguments: forecastDay);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              previous.dailyForecastStatus != current.dailyForecastStatus ||
              previous.dailyForecast != current.dailyForecast,
      builder: (context, state) {
        final forecasts = state.dailyForecast?.dailyForecasts;

        if (forecasts == null || forecasts.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Gap(16), _buildForecastContainer(context, forecasts)],
        );
      },
    );
  }

  Widget _buildForecastContainer(BuildContext context, List<ForecastDay> forecasts) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(children: [_buildHeader(context), _buildForecastList(context, forecasts)]),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Daily Forecast',
            style: context.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          AppInkwell(
            onTap: () => _onViewAllTapped(context),
            child: Text(
              'View All',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastList(BuildContext context, List<ForecastDay> forecasts) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecasts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => _buildForecastItem(context, forecasts[index], index),
      separatorBuilder:
          (context, index) => const Divider(thickness: 1, height: 1, color: Colors.white24),
    );
  }

  Widget _buildForecastItem(BuildContext context, ForecastDay forecastDay, int index) {
    final dayLabel = _getDayLabel(forecastDay, index);
    final dateString = _getFormattedDate(forecastDay);
    final maxTemp = forecastDay.temperature?.maximum?.value;
    final minTemp = forecastDay.temperature?.minimum?.value;
    final humidity = forecastDay.day?.relativeHumidity?.average;
    final iconCode = forecastDay.day?.icon ?? 0;

    return AppInkwell(
      onTap: () => _onForecastItemTapped(context, forecastDay, index),
      decoration:
          index == 0
              ? const BoxDecoration(border: Border(top: BorderSide(color: Colors.white24)))
              : null,
      padding: const EdgeInsets.all(_padding),
      child: Row(
        children: [
          _buildDateColumn(context, dayLabel, dateString),
          const Gap(16),
          _buildWeatherIcon(iconCode),
          const Gap(16),
          _buildTemperatureRow(context, maxTemp, minTemp),
          const Spacer(),
          _buildHumidityIndicator(context, humidity),
        ],
      ),
    );
  }

  Widget _buildDateColumn(BuildContext context, String? dayLabel, String? dateString) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dayLabel ?? '',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          if (dateString != null)
            Text(dateString, style: context.textTheme.labelSmall?.copyWith(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildWeatherIcon(int iconCode) {
    return AppIcon(icon: Utils.getIconAsset(iconCode));
  }

  Widget _buildTemperatureRow(BuildContext context, dynamic maxTemp, dynamic minTemp) {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          Text(
            '${maxTemp ?? '--'}°',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Gap(8),
          Text(
            '${minTemp ?? '--'}°',
            style: context.textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildHumidityIndicator(BuildContext context, dynamic humidity) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.water_drop_outlined, color: Colors.white54, size: _iconSize),
        const Gap(4),
        Text(
          '${humidity ?? '--'}%',
          style: context.textTheme.labelMedium?.copyWith(color: Colors.white54),
        ),
      ],
    );
  }

  String? _getDayLabel(ForecastDay forecastDay, int index) {
    if (index == 0) return 'Today';
    return forecastDay.date?.toDate?.dayOfWeek;
  }

  String? _getFormattedDate(ForecastDay forecastDay) {
    return forecastDay.date?.reformatDateString(newFormat: DateFormatPattern.dateShort);
  }
}
