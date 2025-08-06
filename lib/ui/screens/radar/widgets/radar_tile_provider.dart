import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/datetime_extension.dart';
import 'package:mimemo/models/entities/zxy/zxy.dart';
import 'package:mimemo/models/enums/app_map_type.dart';
import 'package:mimemo/repositories/radar_repository.dart';

class RadarTileProvider implements TileProvider {
  RadarTileProvider({
    required this.radarRepository,
    required this.appMapType,
    this.defaultZoom = 8,
    this.tileSize = 256,
  });

  final RadarRepository radarRepository;
  final AppMapType appMapType;
  final int defaultZoom;
  final int tileSize;

  // Cache for current timestamp to avoid multiple calculations
  static String? _cachedTimestamp;
  static DateTime? _lastUpdate;
  static const _timestampCacheDuration = Duration(seconds: 30);

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    final zxy = ZXY(z: zoom ?? defaultZoom, x: x, y: y);
    final data = await _getTileData(zxy);
    return Tile(tileSize, tileSize, data);
  }

  Future<Uint8List> _getTileData(ZXY zxy) async {
    return switch (appMapType) {
      AppMapType.radar ||
      // TODO
      AppMapType.forecastEyePath => radarRepository.getFutureRadar(zxy, _getCurrentTimestamp()),

      AppMapType.clouds => radarRepository.getCloudSatellite(
        zxy,
        _getCurrentTimestamp(),
      ),

      AppMapType.colorEnhancedClouds => radarRepository.getCloudSatellite(
        zxy,
        _getCurrentTimestamp(),
        '20',
      ),

      AppMapType.waterVapor => radarRepository.getWaterVapor(
        zxy,
        _getCurrentTimestamp(),
      ),

      AppMapType.temperature || AppMapType.temperatureForecast =>
        radarRepository.getCurrentTemperature(zxy, _getCurrentTimestamp()),

      // Time-independent tiles
      AppMapType.risk => radarRepository.getRiskTropical(zxy),

      AppMapType.rainfallAmounts => radarRepository.getRainFallAmounts(zxy),

      AppMapType.forecastedMaximumSustainedWinds => radarRepository.getMaximumSustainedWinds(zxy),

      AppMapType.forecastedMaximumWindGusts => radarRepository.getMaximumWindGusts(zxy),

      AppMapType.stormSurge => radarRepository.getStormSurge(zxy),

      AppMapType.watchesAndWarnings => radarRepository.getWatchesAndWarnings(
        zxy,
      ),
    };
  }

  String _getCurrentTimestamp() {
    final now = DateTime.now().toUtc();

    // Use cached timestamp if still valid
    if (_cachedTimestamp != null &&
        _lastUpdate != null &&
        now.difference(_lastUpdate!) < _timestampCacheDuration) {
      return _cachedTimestamp!;
    }

    // Update cache
    _cachedTimestamp = now.toFormatedString(DateFormatPattern.dateTimeFull);
    _lastUpdate = now;

    return _cachedTimestamp!;
  }

  // Helper method to clear timestamp cache if needed
  static void clearTimestampCache() {
    _cachedTimestamp = null;
    _lastUpdate = null;
  }
}
