import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/models/enums/temperature_color.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/daily/widgets/bottom_sheet_bar.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';

class DailyScreen extends StatelessWidget {
  const DailyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => DailyCubit(
            forecastRepository: locator<ForecastRepository>(),
            mainCubit: context.read<MainCubit>(),
          )..init(),
      child: const DailyView(),
    );
  }
}

class DailyView extends StatelessWidget {
  const DailyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DailyCubit, DailyState>(
        builder: (context, state) {
          return BottomSheetBar(
            header: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      state.selectedDay?.date ?? '',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                final listMaxTemperature =
                    state.dailyForecast?.dailyForecasts?.fold<double>(0, (max, forecast) {
                      final temp = forecast.temperature?.maximum?.value ?? 0;
                      return temp > max ? temp : max;
                    }) ??
                    0;
                final listMinDegree =
                    state.dailyForecast?.dailyForecasts?.fold<double>(double.infinity, (
                      min,
                      forecast,
                    ) {
                      // Start with infinity
                      final temp = forecast.temperature?.minimum?.value ?? double.infinity;
                      return temp < min ? temp : min; // Changed > to
                    }) ??
                    0;
                return ListView.builder(
                  itemCount: state.dailyForecast?.dailyForecasts?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final dailyForecasts = state.dailyForecast?.dailyForecasts ?? [];
                    final forecastDay = dailyForecasts[index];
                    final dayMaxTemperature = forecastDay.temperature?.maximum?.value ?? 0;
                    final dayMinTemperature = forecastDay.temperature?.minimum?.value ?? 0;
                    final (colors, stops) = TemperatureColorExtension.getGradientColorsFromEnum(
                      dayMinTemperature,
                      dayMaxTemperature,
                    );
                    return DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(right: BorderSide(color: Colors.white24)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(forecastDay.date?.toDate?.dayOfWeek ?? ''),
                            Text(
                              forecastDay.date?.reformatDateString(
                                    newFormat: DateFormatPattern.day,
                                  ) ??
                                  '',
                            ),
                            AppIcon(icon: Utils.getIconAsset(forecastDay.day?.icon ?? 0)),
                            const Gap(8),
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final aDegreeSpace =
                                      constraints.maxHeight /
                                      (listMaxTemperature - listMinDegree + 4);
                                  final topSpace =
                                      aDegreeSpace * (listMaxTemperature - dayMaxTemperature);
                                  final barHeight =
                                      (dayMaxTemperature - dayMinTemperature) * aDegreeSpace;
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Gap(topSpace),
                                      Text(dayMaxTemperature.toString()),
                                      const Gap(2),
                                      Container(
                                        width: 20,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: colors,
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: stops,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.white12,
                                              blurRadius: 2,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                        ),
                                        height: barHeight,
                                      ),
                                      const Gap(2),
                                      Text(dayMinTemperature.toString()),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const Gap(8),
                            Text(forecastDay.day?.relativeHumidity?.average?.toString() ?? ''),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            expandedSliver: SliverList.builder(
              itemBuilder: (context, index) {
                return ListTile(title: Text(index.toString()));
              },
            ),
          );
        },
      ),
    );
  }
}
