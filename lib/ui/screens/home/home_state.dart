part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus oneMinuteCastStatus;
  final OneMinuteCast? oneMinuteCast;

  const HomeState({this.oneMinuteCast, this.oneMinuteCastStatus = LoadStatus.initial});

  @override
  List<Object?> get props => [oneMinuteCast, oneMinuteCastStatus];

  HomeState copyWith({OneMinuteCast? oneMinuteCast, LoadStatus? oneMinuteCastStatus}) => HomeState(
    oneMinuteCast: oneMinuteCast ?? this.oneMinuteCast,
    oneMinuteCastStatus: oneMinuteCastStatus ?? this.oneMinuteCastStatus,
  );
}
