part of 'daily_cubit.dart';

class DailyState extends Equatable {
  const DailyState({
    this.loadStatus = LoadStatus.initial,
    this.dailyForecast,
    this.selectedDay,
    this.selectedDayClimo,
  });

  final LoadStatus loadStatus;
  final DailyForecast? dailyForecast;
  final ForecastDay? selectedDay;
  final ClimoSummary? selectedDayClimo;

  @override
  List<Object?> get props => [loadStatus, dailyForecast, selectedDay, selectedDayClimo];

  DailyState copyWith({
    LoadStatus? loadStatus,
    DailyForecast? dailyForecast,
    ForecastDay? selectedDay,
    ClimoSummary? selectedDayClimo,
  }) {
    return DailyState(
      loadStatus: loadStatus ?? this.loadStatus,
      dailyForecast: dailyForecast ?? this.dailyForecast,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedDayClimo: selectedDayClimo ?? this.selectedDayClimo,
    );
  }
}
