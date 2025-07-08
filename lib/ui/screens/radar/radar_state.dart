part of 'radar_cubit.dart';

class RadarState extends Equatable {
  const RadarState({
    this.loadStatus = LoadStatus.initial,
    this.precipitationColors = const {},
    this.tileOverlays = const {},
    this.currentMapType = AppMapType.radar,
  });

  final LoadStatus loadStatus;
  final Map<String?, List<MinuteColor>> precipitationColors;
  final AppMapType currentMapType;
  final Set<TileOverlay> tileOverlays;

  @override
  List<Object?> get props => [
    loadStatus,
    precipitationColors,
    currentMapType,
    tileOverlays,
  ];

  RadarState copyWith({
    LoadStatus? loadStatus,
    Map<String?, List<MinuteColor>>? precipitationColors,
    AppMapType? currentMapType,
    Set<TileOverlay>? tileOverlays,
  }) {
    return RadarState(
      loadStatus: loadStatus ?? this.loadStatus,
      precipitationColors: precipitationColors ?? this.precipitationColors,
      currentMapType: currentMapType ?? this.currentMapType,
      tileOverlays: tileOverlays ?? this.tileOverlays,
    );
  }
}
