part of 'daily_cubit.dart';

class DailyState extends Equatable {
  const DailyState({this.loadStatus = LoadStatus.initial, this.dailyForecast, this.selectedDay});

  final LoadStatus loadStatus;
  final DailyForecast? dailyForecast;
  final ForecastDay? selectedDay;

  @override
  List<Object?> get props => [loadStatus, dailyForecast, selectedDay];

  DailyState copyWith({
    LoadStatus? loadStatus,
    DailyForecast? dailyForecast,
    ForecastDay? selectedDay,
  }) {
    return DailyState(
      loadStatus: loadStatus ?? this.loadStatus,
      dailyForecast: dailyForecast ?? this.dailyForecast,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}
