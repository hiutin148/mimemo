import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/enums/temperature_color.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/daily/widgets/bottom_sheet_bar.dart';
import 'package:mimemo/ui/screens/daily/widgets/selected_day_detail.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';
import 'package:mimemo/ui/widgets/app_inkwell.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _DailyViewState();
}

class _DailyViewState extends State<DailyScreen> with SingleTickerProviderStateMixin {
  final BottomSheetBarController bottomSheetBarController = BottomSheetBarController();

  void _onForecastItemPressed(ForecastDay? day) {
    context.read<DailyCubit>().changeSelectedDay(day);
    bottomSheetBarController.expand();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return BottomSheetBar(
              controller: bottomSheetBarController,
              header: _buildBottomSheetHeader(context),
              body: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth,
                        height: kToolbarHeight,
                        child: const TabBar(tabs: [Tab(text: '15 days'), Tab(text: '45 days')]),
                      ),
                    ],
                  ),
                  Expanded(child: _buildForecastList()),
                ],
              ),
              expandedSliver: _buildExpandedSliver(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomSheetHeader(BuildContext context) {
    return BlocSelector<DailyCubit, DailyState, ForecastDay?>(
      builder: (context, selectedDay) {
        final selectedDate = selectedDay?.date ?? DateTime.now().toString();
        final displayDate = selectedDate.reformatDateString(
          newFormat: DateFormatPattern.weekDayAndDate,
        );
        return Center(
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
                  displayDate ?? '',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      selector: (state) => state.selectedDay,
    );
  }

  Widget _buildForecastList() {
    return BlocSelector<DailyCubit, DailyState, DailyForecast?>(
      builder: (context, dailyForecast) {
        final forecasts =
            dailyForecast?.dailyForecasts?.getRange(0, 14).whereType<ForecastDay>().toList();

        if (forecasts == null || forecasts.isEmpty) {
          return const Center(child: Text('No forecast data available'));
        }

        final (max, min) = _calculateTemperatureRange(forecasts);

        return ListView.builder(
          itemCount: forecasts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _ForecastItem(
              forecast: forecasts[index],
              maxTem: max,
              minTem: min,
              key: ValueKey(forecasts[index].date),
              onDayPressed: _onForecastItemPressed,
            );
          },
        );
      },
      selector: (state) => state.dailyForecast,
    );
  }

  Widget _buildExpandedSliver() {
    return const SelectedDayDetail();
  }

  (double, double) _calculateTemperatureRange(List<ForecastDay> forecasts) {
    var maxTemp = double.negativeInfinity;
    var minTemp = double.infinity;

    for (final forecast in forecasts) {
      final max = forecast.temperature?.maximum?.value ?? 0.0;
      final min = forecast.temperature?.minimum?.value ?? 0.0;

      if (max > maxTemp) maxTemp = max;
      if (min < minTemp) minTemp = min;
    }

    return (
      maxTemp == double.negativeInfinity ? 0.0 : maxTemp,
      minTemp == double.infinity ? 0.0 : minTemp,
    );
  }
}

class _ForecastItem extends StatelessWidget {
  const _ForecastItem({
    required this.forecast,
    required this.minTem,
    required this.maxTem,
    required this.onDayPressed,
    super.key,
  });

  final ForecastDay forecast;
  final double minTem;
  final double maxTem;
  final void Function(ForecastDay? day) onDayPressed;

  @override
  Widget build(BuildContext context) {
    final dayMaxTemp = forecast.temperature?.maximum?.value ?? 0.0;
    final dayMinTemp = forecast.temperature?.minimum?.value ?? 0.0;

    final (colors, stops) = TemperatureColorExtension.getGradientColorsFromEnum(
      dayMinTemp,
      dayMaxTemp,
    );

    return GestureDetector(
      onTap: () => onDayPressed(forecast),
      behavior: HitTestBehavior.translucent,

      child: DecoratedBox(
        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.white24))),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDateInfo(context, forecast),
              const Gap(16),
              _buildWeatherIcon(),
              const Gap(16),
              Expanded(
                child: _buildTemperatureBar(
                  colors: colors,
                  stops: stops,
                  dayMaxTemp: dayMaxTemp,
                  dayMinTemp: dayMinTemp,
                ),
              ),
              const Gap(8),
              _buildHumidityInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateInfo(BuildContext context, ForecastDay day) {
    return Column(
      spacing: 8,
      children: [
        Text(forecast.date?.toDate?.dayOfWeek ?? '', style: context.textTheme.bodySmall?.w600),
        BlocSelector<DailyCubit, DailyState, ForecastDay?>(
          builder: (context, selectedDay) {
            final isSelected = selectedDay?.date == day.date;
            return Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white70 : null,
                shape: BoxShape.circle,
              ),
              child: Text(
                forecast.date?.reformatDateString(newFormat: DateFormatPattern.day) ?? '',
                style: context.textTheme.bodySmall?.w600.copyWith(
                  color: isSelected ? AppColors.primary : Colors.white,
                ),
              ),
            );
          },
          selector: (state) => state.selectedDay,
        ),
      ],
    );
  }

  Widget _buildWeatherIcon() {
    return AppInkWell(
      onTap: () {},
      child: AppIcon(icon: Utils.getIconAsset(forecast.day?.icon ?? 0)),
    );
  }

  Widget _buildTemperatureBar({
    required List<Color> colors,
    required List<double>? stops,
    required double dayMaxTemp,
    required double dayMinTemp,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final temperatureRangeSpan = maxTem - minTem;
        final textHeight = context.textTheme.bodyMedium?.height ?? 0;
        final textFont = context.textTheme.bodyMedium?.fontSize ?? 0;
        final degreeSpace =
            (constraints.maxHeight - textHeight * textFont * 2 - 16) / temperatureRangeSpan;
        final topSpace = degreeSpace * (maxTem - dayMaxTemp);
        final barHeight = (dayMaxTemp - dayMinTemp) * degreeSpace;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(topSpace),
            Text(dayMaxTemp.toStringAsFixed(0), style: context.textTheme.bodyMedium),
            const Gap(2),
            Container(
              width: 20,
              height: barHeight.clamp(0.0, constraints.maxHeight),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: stops,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.white12, blurRadius: 2, offset: Offset(1, 1)),
                ],
              ),
            ),
            const Gap(2),
            Text(dayMinTemp.toStringAsFixed(0), style: context.textTheme.bodyMedium),
          ],
        );
      },
    );
  }

  Widget _buildHumidityInfo(BuildContext context) {
    final humidity = forecast.day?.relativeHumidity?.average;
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white24))),
      child: Row(
        children: [
          const Icon(Icons.water_drop_outlined, color: Colors.white, size: 14),
          Text(
            humidity != null ? '${humidity.toStringAsFixed(0)}%' : '',
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
