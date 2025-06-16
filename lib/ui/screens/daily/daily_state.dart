part of 'daily_cubit.dart';

class DailyState extends Equatable {
  const DailyState({
    this.loadStatus = LoadStatus.initial,
    this.dailyForecast,
    this.selectedDay,
    this.selectedDayClimo,
    this.displayingMonth,
  });

  final LoadStatus loadStatus;
  final DailyForecast? dailyForecast;
  final ForecastDay? selectedDay;
  final ClimoSummary? selectedDayClimo;
  final DateTime? displayingMonth;

  @override
  List<Object?> get props => [
    loadStatus,
    dailyForecast,
    selectedDay,
    selectedDayClimo,
    displayingMonth,
  ];

  DailyState copyWith({
    LoadStatus? loadStatus,
    DailyForecast? dailyForecast,
    ForecastDay? selectedDay,
    ClimoSummary? selectedDayClimo,
    DateTime? displayingMonth,
  }) {
    return DailyState(
      loadStatus: loadStatus ?? this.loadStatus,
      dailyForecast: dailyForecast ?? this.dailyForecast,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedDayClimo: selectedDayClimo ?? this.selectedDayClimo,
      displayingMonth: displayingMonth ?? this.displayingMonth,
    );
  }
}
