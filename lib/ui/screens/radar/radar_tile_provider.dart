import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/datetime_extension.dart';
import 'package:mimemo/models/entities/zxy/zxy.dart';
import 'package:mimemo/models/enums/app_map_type.dart';
import 'package:mimemo/repositories/radar_repository.dart';

class RadarTileProvider implements TileProvider {
  RadarTileProvider({required this.radarRepository, required this.appMapType});

  final RadarRepository radarRepository;
  final AppMapType appMapType;

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    final data = switch (appMapType) {
      AppMapType.radar => await radarRepository.getFutureRadar(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.forecastEyePath => await radarRepository.getFutureRadar(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.risk => await radarRepository.getFutureRadar(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.rainfallAmounts => await radarRepository.getFutureRadar(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.forecastedMaximumSustainedWinds =>
        await radarRepository.getFutureRadar(
          ZXY(z: zoom ?? 8, x: x, y: y),
          DateTime.now().toUtc().toFormatedString(
            DateFormatPattern.dateTimeFull,
          ),
        ),
      AppMapType.forecastedMaximumWindGusts =>
        await radarRepository.getFutureRadar(
          ZXY(z: zoom ?? 8, x: x, y: y),
          DateTime.now().toUtc().toFormatedString(
            DateFormatPattern.dateTimeFull,
          ),
        ),
      AppMapType.stormSurge => await radarRepository.getFutureRadar(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.clouds => await radarRepository.getCloudSatellite(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.colorEnhancedClouds => await radarRepository.getFutureRadar(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.waterVapor => await radarRepository.getFutureRadar(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.temperature => await radarRepository.getCurrentTemperature(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.watchesAndWarnings => await radarRepository.getFutureRadar(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
      AppMapType.temperatureForecast => await radarRepository.getFutureRadar(
        ZXY(z: zoom ?? 8, x: x, y: y),
        DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull),
      ),
    };

    return Tile(256, 256, data);
  }
}
