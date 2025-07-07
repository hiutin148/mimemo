part of 'radar_cubit.dart';

class RadarState extends Equatable {
  const RadarState({this.loadStatus = LoadStatus.initial});

  final LoadStatus loadStatus;

  @override
  List<Object?> get props => [loadStatus];
}
