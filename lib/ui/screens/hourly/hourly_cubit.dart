import 'package:equatable/equatable.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/base/base_cubit.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/string_extension.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/forecast_repository.dart';

part 'hourly_state.dart';

class HourlyCubit extends BaseCubit<HourlyState> {
  HourlyCubit({required this.mainCubit, required this.forecastRepository})
    : super(const HourlyState());

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
          selectedForecast?.dateTime?.reformatDateString(newFormat: DateFormatPattern.dayOfWeek) ??
          '';
      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          hourlyForecasts: hourlyForecasts,
          selectedForecast: selectedForecast,
          currentDay: currentDay,
        ),
      );
    } on Exception catch (e) {
      logger.e(e);
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> init() async {
    return _fetch(LoadStatus.loading);
  }

  Future<void> refresh() async {
    return _fetch(LoadStatus.refreshing);
  }
}
