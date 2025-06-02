part of 'main_cubit.dart';

class MainState extends Equatable {
  final PositionInfo? positionInfo;

  const MainState({this.positionInfo});

  @override
  List<Object?> get props => [positionInfo];

  MainState copyWith({PositionInfo? positionInfo}) =>
      MainState(positionInfo: positionInfo ?? this.positionInfo);
}
