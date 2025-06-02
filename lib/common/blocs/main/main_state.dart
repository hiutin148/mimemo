part of 'main_cubit.dart';

class MainState extends Equatable {
  final PositionInfo? positionInfo;
  final LoadStatus loadStatus;

  const MainState({this.positionInfo, this.loadStatus = LoadStatus.initial});

  @override
  List<Object?> get props => [positionInfo, loadStatus];

  MainState copyWith({PositionInfo? positionInfo, LoadStatus? loadStatus}) =>
      MainState(
        positionInfo: positionInfo ?? this.positionInfo,
        loadStatus: loadStatus ?? this.loadStatus,
      );
}
