part of 'main_cubit.dart';

class MainState extends Equatable {

  const MainState({
    this.positionInfo,
    this.loadStatus = LoadStatus.initial,
    this.minuteColors = const [],
  });
  final PositionInfo? positionInfo;
  final List<MinuteColor> minuteColors;
  final LoadStatus loadStatus;

  @override
  List<Object?> get props => [positionInfo, loadStatus, minuteColors];

  MainState copyWith({
    PositionInfo? positionInfo,
    LoadStatus? loadStatus,
    List<MinuteColor>? minuteColors,
  }) => MainState(
    positionInfo: positionInfo ?? this.positionInfo,
    loadStatus: loadStatus ?? this.loadStatus,
    minuteColors: minuteColors ?? this.minuteColors,
  );
}
