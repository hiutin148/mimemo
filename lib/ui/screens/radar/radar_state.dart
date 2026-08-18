part of 'radar_cubit.dart';

class RadarState extends Equatable {
  const RadarState({
    this.loadStatus = LoadStatus.initial,
    this.currentMapType = AppMapType.radar,
    this.tileUrl,
    this.precipitationColors = const {},
    this.timestamps = const [],
    this.selectedTimestampIndex = 0,
    this.isPlaying = false,
  });

  final LoadStatus loadStatus;
  final AppMapType currentMapType;
  final String? tileUrl;
  final Map<String?, List<MinuteColor>> precipitationColors;

  final List<DateTime> timestamps;
  final int selectedTimestampIndex;
  final bool isPlaying;

  DateTime? get selectedTimestamp =>
      timestamps.isNotEmpty ? timestamps[selectedTimestampIndex] : null;

  RadarState copyWith({
    LoadStatus? loadStatus,
    AppMapType? currentMapType,
    String? tileUrl,
    Map<String?, List<MinuteColor>>? precipitationColors,
    List<DateTime>? timestamps,
    int? selectedTimestampIndex,
    bool? isPlaying,
  }) {
    return RadarState(
      loadStatus: loadStatus ?? this.loadStatus,
      currentMapType: currentMapType ?? this.currentMapType,
      tileUrl: tileUrl ?? this.tileUrl,
      precipitationColors: precipitationColors ?? this.precipitationColors,
      timestamps: timestamps ?? this.timestamps,
      selectedTimestampIndex: selectedTimestampIndex ?? this.selectedTimestampIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    currentMapType,
    tileUrl,
    precipitationColors,
    timestamps,
    selectedTimestampIndex,
    isPlaying,
  ];
}