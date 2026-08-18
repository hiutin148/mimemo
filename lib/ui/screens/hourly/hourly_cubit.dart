import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
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

  Future<void> init() async {
    return _fetch(LoadStatus.loading);
  }

  Future<void> refresh() => _fetch(LoadStatus.refreshing);

  Future<void> _fetch(LoadStatus loadStatus) => guard(() async {
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
  }, onError: (_) => emit(state.copyWith(loadStatus: LoadStatus.failure)));

  List<HourlyDateData> _getHourlyDateDataList(
    List<HourlyForecast> hourlyForecasts,
  ) {
    final dailyForecastMap = _buildDailyForecastMap();

    return groupBy(
      hourlyForecasts.getRange(0, 72).where((f) => f.dateTime != null),
      (HourlyForecast f) =>
          f.dateTime!.reformatDateString(newFormat: DateFormatPattern.date)!,
    ).entries.map((entry) {
      final dateString = entry.key;
      final forecasts = entry.value;
      final dayForecast = dailyForecastMap[dateString];

      final (riseIndex, setIndex) = _findSunEventIndexes(
        forecasts,
        dayForecast?.sun?.rise?.toDefaultDate,
        dayForecast?.sun?.set?.toDefaultDate,
      );

      return HourlyDateData(
        weekday: dateString.reformatDateString(
          oldFormat: DateFormatPattern.date,
          newFormat: DateFormatPattern.dayOfWeek,
        ),
        date: dateString,
        forecasts: forecasts,
        sunRiseIndex: riseIndex,
        sunSetIndex: setIndex,
        sunRise: dayForecast?.sun?.rise?.reformatDateString(
          newFormat: DateFormatPattern.time,
        ),
        sunSet: dayForecast?.sun?.set?.reformatDateString(
          newFormat: DateFormatPattern.time,
        ),
      );
    }).toList();
  }

  Map<String, ForecastDay> _buildDailyForecastMap() {
    final map = <String, ForecastDay>{};
    final dailyForecasts = dailyCubit.state.dailyForecast?.dailyForecasts;
    if (dailyForecasts == null) return map;

    for (final dayForecast in dailyForecasts) {
      final formattedDate = dayForecast.date?.reformatDateString(
        newFormat: DateFormatPattern.date,
      );
      if (formattedDate != null) {
        map[formattedDate] = dayForecast;
      }
    }
    return map;
  }

  (int riseIndex, int setIndex) _findSunEventIndexes(
    List<HourlyForecast> forecasts,
    DateTime? riseDateTime,
    DateTime? setDateTime,
  ) {
    if (riseDateTime == null && setDateTime == null) return (-1, -1);

    var riseIndex = -1;
    var setIndex = -1;

    for (var i = 0; i < forecasts.length; i++) {
      final forecastDateTime = forecasts[i].dateTime?.toDefaultDate;
      if (forecastDateTime == null) continue;

      if (riseIndex == -1 &&
          riseDateTime != null &&
          forecastDateTime.hour - riseDateTime.hour == 1) {
        riseIndex = i;
      }
      if (setIndex == -1 &&
          setDateTime != null &&
          forecastDateTime.hour - setDateTime.hour == 1) {
        setIndex = i;
      }
      if (riseIndex != -1 && setIndex != -1) break;
    }
    return (riseIndex, setIndex);
  }

  void selectForecast(HourlyForecast? forecast) {
    emit(state.copyWith(selectedForecast: forecast));
  }

  void selectAndForceShowDetail(HourlyForecast? forecast) {
    if (state.selectedForecast != null) {
      emit(state.copyWith(selectedForecast: null));
    }
    emit(state.copyWith(selectedForecast: forecast));
  }
}
