import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/enums/temperature_color.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class FifteenDailyForecastItem extends StatelessWidget {
  const FifteenDailyForecastItem({
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
    final dayMaxTemp = (forecast.temperature?.maximum?.value ?? 0.0).roundToDouble();
    final dayMinTemp = (forecast.temperature?.minimum?.value ?? 0.0).roundToDouble();

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
            Text(
              dayMaxTemp.toStringAsFixed(0) + CommonCharacters.degreeChar,
              style: context.textTheme.bodyMedium,
            ),
            const Gap(2),
            Container(
              width: 20,
              height: barHeight.clamp(0.0, constraints.maxHeight),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // stops: stops,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.white12, blurRadius: 2, offset: Offset(1, 1)),
                ],
              ),
            ),
            const Gap(2),
            Text(
              dayMinTemp.toStringAsFixed(0) + CommonCharacters.degreeChar,
              style: context.textTheme.bodyMedium,
            ),
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
