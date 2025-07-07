import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/base/base_cubit.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/string_extension.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';

part 'hourly_state.dart';

class HourlyCubit extends BaseCubit<HourlyState> {
  HourlyCubit({
    required this.mainCubit,
    required this.forecastRepository,
    required this.dailyCubit,
  }) : super(const HourlyState());
  final DailyCubit dailyCubit;
  final MainCubit mainCubit;
  final ForecastRepository forecastRepository;

  Future<void> _fetch(LoadStatus loadStatus) async {
    try {
      emit(state.copyWith(loadStatus: loadStatus));
      final hourlyForecasts = await forecastRepository.getNext240HoursForecast(
        mainCubit.state.positionInfo?.key ?? '',
      );
      final selectedForecast = hourlyForecasts.firstOrNull;
      final currentDay =
          selectedForecast?.dateTime?.reformatDateString(
            newFormat: DateFormatPattern.dayOfWeek,
          ) ??
          '';

      final hourlyDates = _getHourlyDateDataList(hourlyForecasts);

      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          hourlyForecasts: hourlyForecasts,
          selectedForecast: selectedForecast,
          currentDay: currentDay,
          hourlyDates: hourlyDates,
        ),
      );
    } on Exception catch (e) {
      logger.e(e);
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  List<HourlyDateData> _getHourlyDateDataList(
    List<HourlyForecast> hourlyForecasts,
  ) {
    final dailyForecastMap = <String, ForecastDay>{};
    if (dailyCubit.state.dailyForecast?.dailyForecasts != null) {
      for (final dayForecast
          in dailyCubit.state.dailyForecast!.dailyForecasts!) {
        final formattedDate = dayForecast.date?.reformatDateString(
          newFormat: DateFormatPattern.date,
        );
        if (formattedDate != null) {
          dailyForecastMap[formattedDate] = dayForecast;
        }
      }
    }

    final hourlyDates =
        groupBy(
          hourlyForecasts.getRange(0, 72).where((f) => f.dateTime != null),
          (HourlyForecast f) => f.dateTime!.reformatDateString(
            newFormat: DateFormatPattern.date,
          )!,
        ).entries.map((entry) {
          final dateString = entry.key;
          final forecasts = entry.value;

          final dayForecast = dailyForecastMap[dateString];
          final rise = dayForecast?.sun?.rise;
          final set = dayForecast?.sun?.set;

          final riseDateTime = rise?.toDefaultDate;
          final setDateTime = set?.toDefaultDate;

          var riseIndex = -1;
          var setIndex = -1;

          if (riseDateTime != null || setDateTime != null) {
            for (var i = 0; i < forecasts.length; i++) {
              final forecastDateTime = forecasts[i].dateTime?.toDefaultDate;
              if (forecastDateTime != null) {
                // Find first forecast after sunrise
                if (riseIndex == -1 &&
                    riseDateTime != null &&
                    forecastDateTime.hour - riseDateTime.hour == 1) {
                  riseIndex = i;
                }
                // Find first forecast after sunset
                if (setIndex == -1 &&
                    setDateTime != null &&
                    forecastDateTime.hour - setDateTime.hour == 1) {
                  setIndex = i;
                }
                // Early exit if both found
                if (riseIndex != -1 && setIndex != -1) break;
              }
            }
          }

          return HourlyDateData(
            weekday: dateString.reformatDateString(
              oldFormat: DateFormatPattern.date,
              newFormat: DateFormatPattern.dayOfWeek,
            ),
            date: dateString,
            forecasts: forecasts,
            sunRiseIndex: riseIndex,
            sunSetIndex: setIndex,
            sunRise: rise?.reformatDateString(
              newFormat: DateFormatPattern.time,
            ),
            sunSet: set?.reformatDateString(
              newFormat: DateFormatPattern.time,
            ),
          );
        }).toList();
    return hourlyDates;
  }

  Future<void> init() async {
    return _fetch(LoadStatus.loading);
  }

  Future<void> refresh() async {
    return _fetch(LoadStatus.refreshing);
  }

  void selectForecast(HourlyForecast forecast) {
    emit(state.copyWith(selectedForecast: forecast));
  }
}
