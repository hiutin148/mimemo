part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus oneMinuteCastStatus;
  final OneMinuteCast? oneMinuteCast;
  final LoadStatus currentConditionsStatus;
  final CurrentConditions? currentConditions;
  final LoadStatus airQualityStatus;
  final CurrentAirQuality? airQuality;

  const HomeState({
    this.oneMinuteCast,
    this.oneMinuteCastStatus = LoadStatus.initial,
    this.currentConditions,
    this.currentConditionsStatus = LoadStatus.initial,
    this.airQuality,
    this.airQualityStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
    oneMinuteCast,
    oneMinuteCastStatus,
    currentConditions,
    currentConditionsStatus,
    airQuality,
    airQualityStatus,
  ];

  HomeState copyWith({
    OneMinuteCast? oneMinuteCast,
    LoadStatus? oneMinuteCastStatus,
    LoadStatus? currentConditionsStatus,
    CurrentConditions? currentConditions,
    LoadStatus? airQualityStatus,
    CurrentAirQuality? airQuality,
  }) => HomeState(
    oneMinuteCast: oneMinuteCast ?? this.oneMinuteCast,
    oneMinuteCastStatus: oneMinuteCastStatus ?? this.oneMinuteCastStatus,
    currentConditionsStatus: currentConditionsStatus ?? this.currentConditionsStatus,
    currentConditions: currentConditions ?? this.currentConditions,
    airQualityStatus: airQualityStatus ?? this.airQualityStatus,
    airQuality: airQuality ?? this.airQuality,
  );
}
