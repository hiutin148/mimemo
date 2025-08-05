import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/enums/moon_phrase.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/home_card.dart';

class SunMoonStatus extends StatelessWidget {
  const SunMoonStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DailyCubit, DailyState, ForecastDay?>(
      selector: (state) => state.dailyForecast?.dailyForecasts?.firstOrNull,
      builder: (context, forecastDay) {
        // Process sun data
        final sun = forecastDay?.sun;
        final sunRise = sun?.rise?.reformatDateString(newFormat: DateFormatPattern.time12) ?? '';
        final sunSet = sun?.set?.reformatDateString(newFormat: DateFormatPattern.time12) ?? '';
        final sunDuration = _calculateSunDuration(sun);

        // Process moon data
        final moon = forecastDay?.moon;
        final moonPhase = MoonPhase.fromString(moon?.phase ?? '')?.label ?? '';
        final moonRise = moon?.rise?.reformatDateString(newFormat: DateFormatPattern.time12) ?? '';
        final moonSet = moon?.set?.reformatDateString(newFormat: DateFormatPattern.time12) ?? '';

        return HomeCard(
          title: 'Sun and Moon',
          child: Column(
            spacing: 8,
            children: [
              _buildStatusRow(
                context: context,
                icon: Icons.sunny,
                primaryText: sunDuration,
                riseTime: sunRise,
                setTime: sunSet,
              ),
              const Divider(
                color: AppColors.whiteBorderColor,
                thickness: 1,
                height: 0,
              ),
              _buildStatusRow(
                context: context,
                icon: Icons.nightlight,
                primaryText: moonPhase,
                riseTime: moonRise,
                setTime: moonSet,
              ),
            ],
          ),
        );
      },
    );
  }

  String _calculateSunDuration(RiseSet? sun) {
    final riseDate = sun?.rise?.toDefaultDate;
    final setDate = sun?.set?.toDefaultDate;

    if (riseDate == null || setDate == null) return '';

    final duration = setDate.difference(riseDate);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours.toString().padLeft(2, '0')} hrs ${minutes.toString().padLeft(2, '0')} mins';
  }

  Widget _buildStatusRow({
    required BuildContext context,
    required IconData icon,
    required String primaryText,
    required String riseTime,
    required String setTime,
    double leftPadding = 8,
  }) {
    return Row(
      spacing: 8,
      children: [
        Icon(icon, size: 32),
        Expanded(child: Text(primaryText)),
        Gap(leftPadding),
        _buildTimeInfo(context, riseTime, setTime, leftPadding),
      ],
    );
  }

  Widget _buildTimeInfo(BuildContext context, String riseTime, String setTime, double leftPadding) {
    final labelStyle = context.textTheme.labelMedium?.copyWith(
      color: Colors.white54,
      height: context.textTheme.bodyMedium?.height,
    );
    final valueStyle = context.textTheme.bodyMedium;

    return Container(
      padding: EdgeInsets.only(left: leftPadding),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.whiteBorderColor)),
      ),
      child: Row(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Rise', style: labelStyle, textAlign: TextAlign.end),
              Text('Set', style: labelStyle, textAlign: TextAlign.end),
            ],
          ),
          Column(
            children: [
              Text(riseTime, style: valueStyle, textAlign: TextAlign.end),
              Text(setTime, style: valueStyle, textAlign: TextAlign.end),
            ],
          ),
        ],
      ),
    );
  }
}
