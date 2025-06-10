import 'package:equatable/equatable.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/base/base_cubit.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/forecast_repository.dart';

part 'daily_state.dart';

class DailyCubit extends BaseCubit<DailyState> {
  DailyCubit({required this.forecastRepository, required this.mainCubit})
    : super(const DailyState());
  final ForecastRepository forecastRepository;
  final MainCubit mainCubit;

  Future<void> init() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final dailyForecast = await forecastRepository.get10DaysForecast(
        mainCubit.state.positionInfo?.key ?? '',
      );
      emit(state.copyWith(dailyForecast: dailyForecast, loadStatus: LoadStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
      logger.e(e);
    }
  }
}
