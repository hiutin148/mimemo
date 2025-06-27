import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class HourlyList extends StatelessWidget {
  const HourlyList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HourlyCubit, HourlyState, List<HourlyForecast>>(
      builder: (context, forecasts) {
        return AnimationLimiter(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: forecasts.length,
            itemBuilder: (context, index) {
              final hour = forecasts[index];
              final displayTime =
                  hour.dateTime?.reformatDateString(newFormat: DateFormatPattern.time) ?? '';
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  verticalOffset: -200,
                  child: FadeInAnimation(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        spacing: 16,
                        children: [
                          Text(displayTime, style: context.textTheme.bodySmall),
                          AppIcon(icon: Utils.getIconAsset(hour.weatherIcon ?? 0)),
                          Text(
                            '${hour.temperature?.value?.toStringAsFixed(0) ?? 0}°${hour.temperature?.unit ?? ''}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'RealFeel ${hour.temperature?.value?.toStringAsFixed(0) ?? 0}°${hour.temperature?.unit ?? ''}',
                            style: context.textTheme.bodySmall,
                          ),
                          const Spacer(),
                          Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.water_drop_outlined,
                                    color: Colors.white54,
                                    size: 16,
                                  ),
                                  const Gap(2),
                                  Text(
                                    '${hour.relativeHumidity ?? '--'}%',
                                    style: context.textTheme.labelMedium?.copyWith(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                              if (hour.totalLiquid?.value != 0)
                                Text(
                                  '${hour.totalLiquid?.value ?? 0}${hour.totalLiquid?.unit ?? ''}',
                                  style: context.textTheme.labelMedium?.copyWith(
                                    color: Colors.white54,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      selector: (state) => state.hourlyForecasts,
    );
  }
}
