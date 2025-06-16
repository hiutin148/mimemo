import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/daily/widgets/fifteen_daily_forecast_item.dart';

class DailyForecastList extends StatelessWidget {
  const DailyForecastList({required this.onItemTap, super.key});

  final void Function(ForecastDay? day) onItemTap;

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyCubit, DailyState>(
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

          return ListView.builder(
            itemCount: forecasts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return FifteenDailyForecastItem(
                forecast: forecasts[index],
                maxTem: max,
                minTem: min,
                key: ValueKey(forecasts[index].date),
                onDayPressed: onItemTap,
              );
            },
          );
        }
      },
    );
  }
}
