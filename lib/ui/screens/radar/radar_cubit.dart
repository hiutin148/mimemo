import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/datetime_extension.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/enums/app_map_type.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/services/api/api_client_endpoints.dart';

part 'radar_state.dart';

class RadarCubit extends Cubit<RadarState> {
  RadarCubit({required this.mainCubit}) : super(const RadarState());

  final MainCubit mainCubit;
  Timer? _playTimer;

  static const int _pastFrameCount = 12;

  static const Duration _playInterval = Duration(milliseconds: 700);

  void init() {
    try {
      final groupColors = groupBy<MinuteColor, String?>(
        mainCubit.state.minuteColors,
        (color) => color.type,
      );

      final timestamps = _generateTimestamps(state.currentMapType);
      final lastIndex = timestamps.isEmpty ? 0 : timestamps.length - 1;

      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          precipitationColors: groupColors,
          timestamps: timestamps,
          selectedTimestampIndex: lastIndex,
          tileUrl: timestamps.isEmpty
              ? _buildStaticTileUrl(state.currentMapType)
              : _buildTileUrl(state.currentMapType, timestamps[lastIndex]),
        ),
      );
    } on Exception catch (e) {
      logger.e(e);
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void changeMapType(AppMapType mapType) {
    _playTimer?.cancel();

    final timestamps = _generateTimestamps(mapType);
    final lastIndex = timestamps.isEmpty ? 0 : timestamps.length - 1;

    emit(
      state.copyWith(
        currentMapType: mapType,
        timestamps: timestamps,
        selectedTimestampIndex: lastIndex,
        isPlaying: false,
        tileUrl: timestamps.isEmpty
            ? _buildStaticTileUrl(mapType)
            : _buildTileUrl(mapType, timestamps[lastIndex]),
      ),
    );
  }

  void selectTimestampIndex(int index) {
    if (index < 0 || index >= state.timestamps.length) return;

    emit(
      state.copyWith(
        selectedTimestampIndex: index,
        tileUrl: _buildTileUrl(state.currentMapType, state.timestamps[index]),
      ),
    );
  }

  void togglePlay() {
    if (state.isPlaying) {
      _playTimer?.cancel();
      emit(state.copyWith(isPlaying: false));
      return;
    }

    if (state.timestamps.isEmpty) return;

    emit(state.copyWith(isPlaying: true));
    _playTimer = Timer.periodic(_playInterval, (_) {
      final next = (state.selectedTimestampIndex + 1) % state.timestamps.length;
      selectTimestampIndex(next);
    });
  }

  void stopPlay() {
    _playTimer?.cancel();
    if (state.isPlaying) {
      emit(state.copyWith(isPlaying: false));
    }
  }

  List<DateTime> _generateTimestamps(AppMapType mapType) {
    final interval = _intervalFor(mapType);
    if (interval == null) return const [];

    final now = DateTime.now().toUtc();
    final roundedNow = _roundDown(now, interval);

    return List.generate(_pastFrameCount, (i) {
      return roundedNow.subtract(interval * (_pastFrameCount - 1 - i));
    });
  }

  Duration? _intervalFor(AppMapType mapType) {
    return switch (mapType) {
      AppMapType.radar ||
      AppMapType.forecastEyePath => const Duration(minutes: 10),
      AppMapType.clouds ||
      AppMapType.colorEnhancedClouds ||
      AppMapType.waterVapor => const Duration(minutes: 15),
      AppMapType.temperature ||
      AppMapType.temperatureForecast => const Duration(hours: 1),
      AppMapType.risk ||
      AppMapType.rainfallAmounts ||
      AppMapType.forecastedMaximumSustainedWinds ||
      AppMapType.forecastedMaximumWindGusts ||
      AppMapType.stormSurge ||
      AppMapType.watchesAndWarnings => null,
    };
  }

  DateTime _roundDown(DateTime time, Duration interval) {
    final minutes = interval.inMinutes;
    if (minutes >= 60) {
      return DateTime.utc(time.year, time.month, time.day, time.hour);
    }
    final roundedMinute = (time.minute ~/ minutes) * minutes;
    return DateTime.utc(
      time.year,
      time.month,
      time.day,
      time.hour,
      roundedMinute,
    );
  }

  String _buildTileUrl(AppMapType mapType, DateTime timestamp) {
    final endpoint = _endpointFor(mapType);
    return endpoint.needsDateTime
        ? endpoint.template.withDateTime(_formatTimestamp(timestamp))
        : endpoint.template;
  }

  String _buildStaticTileUrl(AppMapType mapType) {
    final endpoint = _endpointFor(mapType);
    return endpoint.needsDateTime
        ? endpoint.template.withDateTime(
            _formatTimestamp(DateTime.now().toUtc()),
          )
        : endpoint.template;
  }

  String _formatTimestamp(DateTime timestamp) {
    return timestamp.toFormatedString(DateFormatPattern.dateTimeFull);
  }

  ({String template, bool needsDateTime}) _endpointFor(AppMapType mapType) {
    return switch (mapType) {
      AppMapType.radar || AppMapType.forecastEyePath => (
        template: ApiClientEndpoints.radarEndpoint,
        needsDateTime: true,
      ),
      AppMapType.clouds => (
        template: ApiClientEndpoints.cloudSatelliteEndpoint,
        needsDateTime: true,
      ),
      AppMapType.colorEnhancedClouds => (
        template: '${ApiClientEndpoints.cloudSatelliteEndpoint}20',
        needsDateTime: true,
      ),
      AppMapType.waterVapor => (
        template: ApiClientEndpoints.waterVaporEndpoint,
        needsDateTime: true,
      ),
      AppMapType.temperature || AppMapType.temperatureForecast => (
        template: ApiClientEndpoints.currentTemperatureEndpoint,
        needsDateTime: true,
      ),
      AppMapType.risk => (
        template: ApiClientEndpoints.riskTropicalEndpoint,
        needsDateTime: false,
      ),
      AppMapType.rainfallAmounts => (
        template: ApiClientEndpoints.rainFallAmountsEndpoint,
        needsDateTime: false,
      ),
      AppMapType.forecastedMaximumSustainedWinds => (
        template: ApiClientEndpoints.maximumSustainedWindsEndpoint,
        needsDateTime: false,
      ),
      AppMapType.forecastedMaximumWindGusts => (
        template: ApiClientEndpoints.maximumWindGustsEndpoint,
        needsDateTime: false,
      ),
      AppMapType.stormSurge => (
        template: ApiClientEndpoints.stormSurgeEndpoint,
        needsDateTime: false,
      ),
      AppMapType.watchesAndWarnings => (
        template: ApiClientEndpoints.watchesAndWarningsEndpoint,
        needsDateTime: false,
      ),
    };
  }

  String? tileUrlForIndex(int index) {
    final timestamps = state.timestamps;
    if (index < 0 || index >= timestamps.length) return null;
    return _buildTileUrl(state.currentMapType, timestamps[index]);
  }

  @override
  Future<void> close() {
    _playTimer?.cancel();
    return super.close();
  }
}
