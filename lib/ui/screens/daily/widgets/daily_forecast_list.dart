import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/daily/widgets/fifteen_daily_forecast_item.dart';

class DailyForecastList extends StatefulWidget {
  const DailyForecastList({required this.onItemTap, super.key});

  final void Function(ForecastDay? day) onItemTap;

  @override
  State<DailyForecastList> createState() => _DailyForecastListState();
}

class _DailyForecastListState extends State<DailyForecastList> {
  final GlobalKey<State<StatefulWidget>> _firstNextMonthKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  late final ValueNotifier<String> _month;
  final DateTime now = DateTime.now();

  late final String _currentMonth;

  late final String _nextMonth;

  static const double _itemWidth = 72;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkIfJuly1IsNearLeft);
    _currentMonth = now.toFormatedString(DateFormatPattern.monthFull);
    final nextMonthDate = DateTime(now.year, now.month + 1);
    _nextMonth = nextMonthDate.toFormatedString(DateFormatPattern.monthFull);
    _month = ValueNotifier(_currentMonth);
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

  void _checkIfJuly1IsNearLeft() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _firstNextMonthKey.currentContext;
      if (context != null) {
        final box = context.findRenderObject()! as RenderBox;
        final position = box.localToGlobal(Offset.zero);

        const threshold = 20.0;

        if (position.dx < threshold && _month.value != _nextMonth) {
          _month.value = _nextMonth;
        } else if (position.dx >= threshold && _month.value != _currentMonth) {
          _month.value = _currentMonth;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyCubit, DailyState>(
      builder: (context, state) {
        if (state.loadStatus == LoadStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final dailyForecast = state.dailyForecast;
          final forecasts =
              dailyForecast?.dailyForecasts?.getRange(0, 14).whereType<ForecastDay>().toList();

          if (forecasts == null || forecasts.isEmpty) {
            return const Center(child: Text('No forecast data available'));
          }

          final (max, min) = _calculateTemperatureRange(forecasts);

          return Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white24)),
                ),
                padding: const EdgeInsets.all(16),
                child: ValueListenableBuilder<String>(
                  builder: (context, value, child) {
                    return Text(value, style: context.textTheme.titleMedium);
                  },
                  valueListenable: _month,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: forecasts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final date = forecasts[index].date?.toDefaultDate;
                    final isFirstNextMonth = date?.month != DateTime.now().month && date?.day == 1;
                    return SizedBox(
                      width: _itemWidth,
                      child: FifteenDailyForecastItem(
                        key: isFirstNextMonth ? _firstNextMonthKey : null,
                        forecast: forecasts[index],
                        maxTem: max,
                        minTem: min,
                        onDayPressed: widget.onItemTap,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
      listenWhen: (previous, current) => previous.selectedDay != current.selectedDay,
      listener: (BuildContext context, DailyState state) {
        final selectedIndex =
            state.dailyForecast?.dailyForecasts
                ?.indexWhere((element) => element.date == state.selectedDay?.date)
                .toDouble() ??
            0.0;
        _scrollController.animateTo(
          selectedIndex * _itemWidth - context.width / 2 + _itemWidth / 2,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      },
    );
  }
}
