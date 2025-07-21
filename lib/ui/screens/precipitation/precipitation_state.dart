part of 'precipitation_cubit.dart';

class PrecipitationState extends Equatable {
  const PrecipitationState({
    this.loadStatus = LoadStatus.initial,
    this.focusedIndex = 0,
    this.selectedMinute,
    this.nextHours = const [],
    this.selectedHour,
    this.oneMinuteCast,
  });

  final LoadStatus loadStatus;
  final OneMinuteCast? oneMinuteCast;
  final int focusedIndex;
  final MinuteInterval? selectedMinute;
  final List<HourlyForecast> nextHours;
  final HourlyForecast? selectedHour;

  @override
  List<Object?> get props => [
    loadStatus,
    focusedIndex,
    selectedMinute,
    nextHours,
    selectedHour,
    oneMinuteCast,
  ];

  PrecipitationState copyWith({
    LoadStatus? loadStatus,
    int? focusedIndex,
    MinuteInterval? selectedMinute,
    List<HourlyForecast>? nextHours,
    HourlyForecast? selectedHour,
    OneMinuteCast? oneMinuteCast,
  }) {
    return PrecipitationState(
      loadStatus: loadStatus ?? this.loadStatus,
      focusedIndex: focusedIndex ?? this.focusedIndex,
      selectedMinute: selectedMinute ?? this.selectedMinute,
      nextHours: nextHours ?? this.nextHours,
      selectedHour: selectedHour ?? this.selectedHour,
      oneMinuteCast: oneMinuteCast ?? this.oneMinuteCast,
    );
  }
}
