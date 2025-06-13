import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/daily/widgets/bottom_sheet_bar.dart';
import 'package:mimemo/ui/screens/daily/widgets/fifteen_daily_forecast_item.dart';
import 'package:mimemo/ui/screens/daily/widgets/selected_day_detail.dart';

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
            return FifteenDailyForecastItem(
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
