import 'package:equatable/equatable.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/base/base_cubit.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/climo_summary/climo_summary.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

part 'daily_state.dart';

class DailyCubit extends BaseCubit<DailyState> {
  DailyCubit({required this.forecastRepository, required this.mainCubit})
      : super(const DailyState());

  final ForecastRepository forecastRepository;
  final MainCubit mainCubit;
  BottomSheetBarController? bottomSheetBarController;

  String get _locationKey => mainCubit.state.positionInfo?.key ?? '';

  Future<void> init() => guard(() async {
    bottomSheetBarController ??= BottomSheetBarController();
    emit(state.copyWith(loadStatus: LoadStatus.loading));

    final dailyForecast = await forecastRepository.get45DaysForecast(_locationKey);
    final selectedDay = dailyForecast.dailyForecasts?.firstOrNull;
    final climoSummary = await _getClimoSummaryForSameDayLastYear(
      selectedDay?.date?.toDefaultDate,
    );

    emit(
      state.copyWith(
        dailyForecast: dailyForecast,
        loadStatus: LoadStatus.success,
        selectedDay: selectedDay,
        selectedDayClimo: climoSummary,
      ),
    );
  }, onError: (_) => emit(state.copyWith(loadStatus: LoadStatus.failure)));

  Future<void> changeSelectedDay(ForecastDay? day) => guard(() async {
    emit(state.copyWith(selectedDay: day));

    final climo = await _getClimoSummaryForSameDayLastYear(
      day?.date?.toDefaultDate ?? DateTime.now(),
    );

    bottomSheetBarController?.expand();
    emit(state.copyWith(selectedDayClimo: climo));
  });

  Future<ClimoSummary?> _getClimoSummaryForSameDayLastYear(DateTime? date) async {
    if (date == null) return null;

    return forecastRepository.getClimoSummary(
      locationKey: _locationKey,
      year: (date.year - 1).toString(),
      month: date.month.toString(),
      day: date.day.toString(),
    );
  }
}
