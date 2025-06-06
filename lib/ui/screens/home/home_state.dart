part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus oneMinuteCastStatus;
  final OneMinuteCast? oneMinuteCast;
  final LoadStatus currentConditionsStatus;
  final CurrentConditions? currentConditions;
  final LoadStatus airQualityStatus;
  final CurrentAirQuality? airQuality;
  final LoadStatus next12HoursForecastStatus;

  final List<HourlyForecast> next12HoursForecast;

  const HomeState({
    this.oneMinuteCast,
    this.oneMinuteCastStatus = LoadStatus.initial,
    this.currentConditions,
    this.currentConditionsStatus = LoadStatus.initial,
    this.airQuality,
    this.airQualityStatus = LoadStatus.initial,
    this.next12HoursForecastStatus = LoadStatus.initial,
    this.next12HoursForecast = const [],
  });

  @override
  List<Object?> get props => [
    oneMinuteCast,
    oneMinuteCastStatus,
    currentConditions,
    currentConditionsStatus,
    airQuality,
    airQualityStatus,
    next12HoursForecastStatus,
    next12HoursForecast,
  ];

  HomeState copyWith({
    OneMinuteCast? oneMinuteCast,
    LoadStatus? oneMinuteCastStatus,
    LoadStatus? currentConditionsStatus,
    CurrentConditions? currentConditions,
    LoadStatus? airQualityStatus,
    CurrentAirQuality? airQuality,
    List<HourlyForecast>? next12HoursForecast,
    LoadStatus? next12HoursForecastStatus,
  }) => HomeState(
    oneMinuteCast: oneMinuteCast ?? this.oneMinuteCast,
    oneMinuteCastStatus: oneMinuteCastStatus ?? this.oneMinuteCastStatus,
    currentConditionsStatus: currentConditionsStatus ?? this.currentConditionsStatus,
    currentConditions: currentConditions ?? this.currentConditions,
    airQualityStatus: airQualityStatus ?? this.airQualityStatus,
    airQuality: airQuality ?? this.airQuality,
    next12HoursForecastStatus: next12HoursForecastStatus ?? this.next12HoursForecastStatus,
    next12HoursForecast: next12HoursForecast ?? this.next12HoursForecast,
  );
}
