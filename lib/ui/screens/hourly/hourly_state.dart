part of 'hourly_cubit.dart';

class HourlyState extends Equatable {
  const HourlyState({
    this.loadStatus = LoadStatus.initial,
    this.hourlyForecasts = const [],
    this.selectedForecast,
    this.currentDay = '',
  });

  final LoadStatus loadStatus;
  final List<HourlyForecast> hourlyForecasts;
  final HourlyForecast? selectedForecast;
  final String currentDay;

  @override
  List<Object?> get props => [loadStatus, hourlyForecasts, selectedForecast, currentDay];

  HourlyState copyWith({
    LoadStatus? loadStatus,
    List<HourlyForecast>? hourlyForecasts,
    HourlyForecast? selectedForecast,
    String? currentDay,
  }) {
    return HourlyState(
      loadStatus: loadStatus ?? this.loadStatus,
      hourlyForecasts: hourlyForecasts ?? this.hourlyForecasts,
      selectedForecast: selectedForecast ?? this.selectedForecast,
      currentDay: currentDay ?? this.currentDay,
    );
  }
}
