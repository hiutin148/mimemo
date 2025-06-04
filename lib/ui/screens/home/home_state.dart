part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus oneMinuteCastStatus;
  final OneMinuteCast? oneMinuteCast;
  final LoadStatus currentConditionsStatus;
  final CurrentConditions? currentConditions;

  const HomeState({
    this.oneMinuteCast,
    this.oneMinuteCastStatus = LoadStatus.initial,
    this.currentConditions,
    this.currentConditionsStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
    oneMinuteCast,
    oneMinuteCastStatus,
    currentConditions,
    currentConditionsStatus,
  ];

  HomeState copyWith({
    OneMinuteCast? oneMinuteCast,
    LoadStatus? oneMinuteCastStatus,
    LoadStatus? currentConditionsStatus,
    CurrentConditions? currentConditions,
  }) => HomeState(
    oneMinuteCast: oneMinuteCast ?? this.oneMinuteCast,
    oneMinuteCastStatus: oneMinuteCastStatus ?? this.oneMinuteCastStatus,
    currentConditionsStatus: currentConditionsStatus ?? this.currentConditionsStatus,
    currentConditions: currentConditions ?? this.currentConditions,
  );
}
