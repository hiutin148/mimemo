import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_cubit.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_tab.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/home_card.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class HomeDailyForecast extends StatelessWidget {
  const HomeDailyForecast({super.key});

  static const _padding = 16.0;
  static const _iconSize = 16.0;

  void _onForecastItemTapped(BuildContext context, ForecastDay forecastDay, int index) {
    context.read<DailyCubit>().changeSelectedDay(forecastDay);
    context.read<BottomNavCubit>().switchTab(BottomNavTab.daily.index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyCubit, DailyState>(
      buildWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus ||
          previous.dailyForecast != current.dailyForecast,
      builder: (context, state) {
        final forecasts = state.dailyForecast?.dailyForecasts
            ?.getRange(0, 14)
            .whereType<ForecastDay>()
            .toList();

        if (forecasts == null || forecasts.isEmpty) {
          return const SizedBox.shrink();
        }

        return HomeCard(
          cardContentPadding: 0,
          onTap: () {
            context.read<BottomNavCubit>().switchTab(BottomNavTab.hourly.index);
          },
          title: 'Daily Forecast',
          child: _buildForecastList(context, forecasts),
        );
      },
    );
  }

  Widget _buildForecastList(BuildContext context, List<ForecastDay> forecasts) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecasts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => _buildForecastItem(context, forecasts[index], index),
      separatorBuilder: (context, index) =>
          const Divider(thickness: 1, height: 1, color: Colors.white24),
    );
  }

  Widget _buildForecastItem(BuildContext context, ForecastDay forecastDay, int index) {
    final dayLabel = _getDayLabel(forecastDay, index);
    final dateString = _getFormattedDate(forecastDay);
    final maxTemp = forecastDay.temperature?.maximum?.value;
    final minTemp = forecastDay.temperature?.minimum?.value;
    final humidity = forecastDay.day?.relativeHumidity?.average;
    final iconCode = forecastDay.day?.icon ?? 0;

    return AppInkWell(
      onTap: () => _onForecastItemTapped(context, forecastDay, index),
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
    return forecastDay.date?.toDefaultDate?.dayOfWeek;
  }

  String? _getFormattedDate(ForecastDay forecastDay) {
    return forecastDay.date?.reformatDateString(newFormat: DateFormatPattern.dateShort);
  }
}
