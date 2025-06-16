import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/enums/week_day.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class DailyForecastCalendar extends StatefulWidget {
  const DailyForecastCalendar({required this.onItemTap, super.key});

  final void Function(ForecastDay? day) onItemTap;

  @override
  State<DailyForecastCalendar> createState() => _DailyForecastCalendarState();
}

class _DailyForecastCalendarState extends State<DailyForecastCalendar> {
  late Map<DateTime, List<ForecastDay>> forecastsByMonth;
  late List<DateTime> sortedMonths;
  final GlobalKey<State<StatefulWidget>> _globalKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _listViewKey = GlobalKey();
  final _scrollController = ScrollController();
  late ValueNotifier<String> _displayMonth;

  @override
  void initState() {
    super.initState();
    init(context.read<DailyCubit>().state);
  }

  void init(DailyState dailyState) {
    final dailyForecasts = dailyState.dailyForecast?.dailyForecasts ?? [];

    forecastsByMonth = <DateTime, List<ForecastDay>>{};
    for (final forecast in dailyForecasts) {
      final date = forecast.date?.toDate;
      if (date != null) {
        final monthKey = DateTime(date.year, date.month);
        forecastsByMonth.putIfAbsent(monthKey, () => []).add(forecast);
      }
    }
    sortedMonths = forecastsByMonth.keys.toList()..sort((a, b) => a.compareTo(b));
    _displayMonth = ValueNotifier(sortedMonths[0].toFormatedString(DateFormatPattern.monthFull));
    _scrollController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final listBox = _listViewKey.currentContext?.findRenderObject();
        final targetBox = _globalKey.currentContext?.findRenderObject();

        if (listBox is RenderBox && targetBox is RenderBox) {
          final relativeOffset = targetBox.localToGlobal(Offset.zero, ancestor: listBox);
          final topY = relativeOffset.dy + 40;

          final month0 = sortedMonths[0].toFormatedString(DateFormatPattern.monthFull);
          final month1 = sortedMonths[1].toFormatedString(DateFormatPattern.monthFull);

          final shouldBeMonth = topY <= 0 ? month1 : month0;

          if (_displayMonth.value != shouldBeMonth) {
            _displayMonth.value = shouldBeMonth;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyCubit, DailyState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white24)),
              ),
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: ValueListenableBuilder(
                builder: (context, value, child) {
                  return Text(value, style: context.textTheme.titleMedium);
                },
                valueListenable: _displayMonth,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white24)),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children:
                    WeekDay.values
                        .map(
                          (weekDay) => Expanded(
                            child: Text(
                              weekDay.name.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: context.textTheme.labelSmall,
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                key: _listViewKey,
                controller: _scrollController,
                itemCount: sortedMonths.length,
                itemBuilder: (context, index) {
                  return _buildMonthCalendar(
                    context,
                    index,
                    sortedMonths[index],
                    forecastsByMonth[sortedMonths[index]] ?? [],
                  );
                },
              ),
            ),
          ],
        );
      },
      listener: (BuildContext context, DailyState state) {
        init(state);
      },
    );
  }

  Widget _buildMonthCalendar(
    BuildContext context,
    int index,
    DateTime month,
    List<ForecastDay> forecasts,
  ) {
    final firstForecast = forecasts.firstOrNull;
    var firstWeekdayOffset = firstForecast?.date?.toDate?.weekday ?? 0;
    if (firstWeekdayOffset == 7) {
      firstWeekdayOffset = 0;
    }
    final totalCells = forecasts.length + firstWeekdayOffset;
    final rowCount = (totalCells / 7).ceil();
    return Column(
      children: [
        if (index > 0)
          Container(
            key: _globalKey,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white24))),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              month.toFormatedString(DateFormatPattern.monthFull),
              style: context.textTheme.titleMedium,
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cellWidth = constraints.maxWidth / 7;
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rowCount,
                itemBuilder: (context, rowIndex) {
                  return Row(
                    children: List.generate(7, (colIndex) {
                      final itemIndex = rowIndex * 7 + colIndex - firstWeekdayOffset;

                      if (itemIndex < 0 || itemIndex >= forecasts.length) {
                        return SizedBox(width: cellWidth);
                      } else {
                        final forecastDay = forecasts[itemIndex];
                        final tempHigh =
                            forecastDay.temperature?.maximum?.value?.toStringAsFixed(0) ?? '';
                        final tempLow =
                            forecastDay.temperature?.minimum?.value?.toStringAsFixed(0) ?? '';
                        final icon = forecastDay.day?.icon ?? 0;
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => widget.onItemTap(forecastDay),
                          child: SizedBox(
                            width: cellWidth,
                            child: Center(
                              child: Column(
                                spacing: 8,
                                children: [
                                  BlocSelector<DailyCubit, DailyState, ForecastDay?>(
                                    builder: (context, selectedDay) {
                                      final isSelected = selectedDay?.date == forecastDay.date;
                                      return Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: isSelected ? Colors.white70 : null,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          forecastDay.date?.reformatDateString(
                                                newFormat: DateFormatPattern.day,
                                              ) ??
                                              '',
                                          style: context.textTheme.bodySmall?.w600.copyWith(
                                            color: isSelected ? AppColors.primary : Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                    selector: (state) => state.selectedDay,
                                  ),
                                  AppIcon(icon: Utils.getIconAsset(icon)),
                                  Text(
                                    tempHigh + CommonCharacters.degreeChar,
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    tempLow + CommonCharacters.degreeChar,
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(color: Colors.white24, height: 32);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
