part of 'radar_cubit.dart';

class RadarState extends Equatable {
  const RadarState({
    this.loadStatus = LoadStatus.initial,
    this.precipitationColors = const {},
    this.currentMapType = AppMapType.radar,
    this.tileUrl,
  });

  final LoadStatus loadStatus;
  final Map<String?, List<MinuteColor>> precipitationColors;
  final AppMapType currentMapType;
  final String? tileUrl;

  @override
  List<Object?> get props => [
    loadStatus,
    precipitationColors,
    currentMapType,
    tileUrl,
  ];

  RadarState copyWith({
    LoadStatus? loadStatus,
    Map<String?, List<MinuteColor>>? precipitationColors,
    AppMapType? currentMapType,
    String? tileUrl,
  }) {
    return RadarState(
      loadStatus: loadStatus ?? this.loadStatus,
      precipitationColors: precipitationColors ?? this.precipitationColors,
      currentMapType: currentMapType ?? this.currentMapType,
      tileUrl: tileUrl ?? this.tileUrl,
    );
  }
}