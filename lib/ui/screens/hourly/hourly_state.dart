part of 'hourly_cubit.dart';

class HourlyState extends Equatable {
  const HourlyState({
    this.loadStatus = LoadStatus.initial,
    this.hourlyForecasts = const [],
    this.selectedForecast,
    this.currentDay = '',
    this.weekdayIndices = const [],
    this.hourlyDates = const [],
  });

  final LoadStatus loadStatus;
  final List<HourlyForecast> hourlyForecasts;
  final List<HourlyDateData> hourlyDates;
  final HourlyForecast? selectedForecast;
  final String currentDay;
  final List<int> weekdayIndices;

  @override
  List<Object?> get props => [
    loadStatus,
    hourlyForecasts,
    selectedForecast,
    currentDay,
    weekdayIndices,
    hourlyDates,
  ];

  HourlyState copyWith({
    LoadStatus? loadStatus,
    List<HourlyForecast>? hourlyForecasts,
    HourlyForecast? selectedForecast,
    String? currentDay,
    List<int>? weekdayIndices,
    List<HourlyDateData>? hourlyDates,
  }) {
    return HourlyState(
      loadStatus: loadStatus ?? this.loadStatus,
      hourlyForecasts: hourlyForecasts ?? this.hourlyForecasts,
      selectedForecast: selectedForecast ?? this.selectedForecast,
      currentDay: currentDay ?? this.currentDay,
      weekdayIndices: weekdayIndices ?? this.weekdayIndices,
      hourlyDates: hourlyDates ?? this.hourlyDates,
    );
  }
}

class HourlyDateData {
  HourlyDateData({
    required this.weekday,
    required this.date,
    required this.forecasts,
    this.sunSetIndex,
    this.sunRiseIndex,
    this.sunSet,
    this.sunRise,
  });

  final String? weekday;
  final String? date;
  final List<HourlyForecast>? forecasts;
  final int? sunSetIndex;
  final int? sunRiseIndex;
  final String? sunSet;
  final String? sunRise;
}
