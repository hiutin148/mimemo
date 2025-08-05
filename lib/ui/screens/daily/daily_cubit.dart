import 'package:equatable/equatable.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/utils.dart';
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
  late final BottomSheetBarController bottomSheetBarController;

  Future<void> init() async {
    try {
      bottomSheetBarController = BottomSheetBarController();
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final locationKey = mainCubit.state.positionInfo?.key ?? '';
      final dailyForecast = await forecastRepository.get45DaysForecast(locationKey);
      final selectedDay = dailyForecast.dailyForecasts?.firstOrNull;
      final currentYear = selectedDay?.date?.toDefaultDate?.year;
      final currentMonth = selectedDay?.date?.toDefaultDate?.month;
      final currentDay = selectedDay?.date?.toDefaultDate?.day;
      ClimoSummary? climoSummary;
      if (currentYear != null && currentMonth != null && currentDay != null) {
        final lastYear = currentYear - 1;
        climoSummary = await getClimoSummary(
          locationKey,
          lastYear.toString(),
          currentMonth.toString(),
          currentDay.toString(),
        );
      }
      emit(
        state.copyWith(
          dailyForecast: dailyForecast,
          loadStatus: LoadStatus.success,
          selectedDay: selectedDay,
          selectedDayClimo: climoSummary,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
      logger.e(e);
    }
  }

  Future<ClimoSummary> getClimoSummary(String locationKey, String year, String month, String day) {
    return forecastRepository.getClimoSummary(
      locationKey: locationKey,
      year: year,
      month: month,
      day: day,
    );
  }

  Future<void> changeSelectedDay(ForecastDay? day) async {
    emit(state.copyWith(selectedDay: day));
    final date = day?.date?.toDefaultDate ?? DateTime.now();
    final climo = await getClimoSummary(
      mainCubit.state.positionInfo?.key ?? '',
      (date.year - 1).toString(),
      date.month.toString(),
      date.day.toString(),
    );
    bottomSheetBarController.expand();
    emit(state.copyWith(selectedDayClimo: climo));
  }
}
