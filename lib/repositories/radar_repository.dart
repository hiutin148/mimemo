import 'dart:typed_data';

import 'package:mimemo/models/entities/zxy/zxy.dart';
import 'package:mimemo/services/api/api_client.dart';

abstract class RadarRepository {
  Future<Uint8List> getFutureRadar(ZXY zxy, String dateTime);

  Future<Uint8List> getCloudSatellite(
    ZXY zxy,
    String dateTime, [
    String? displayMode,
  ]);

  Future<Uint8List> getCurrentTemperature(ZXY zxy, String dateTime);

  Future<Uint8List> getRiskTropical(ZXY zxy);

  Future<Uint8List> getRainFallAmounts(ZXY zxy);

  Future<Uint8List> getMaximumSustainedWinds(ZXY zxy);

  Future<Uint8List> getStormSurge(ZXY zxy);

  Future<Uint8List> getWatchesAndWarnings(ZXY zxy);

  Future<Uint8List> getWaterVapor(ZXY zxy, String dateTime);

  Future<Uint8List> getMaximumWindGusts(ZXY zxy);
}

class RadarRepositoryImpl extends RadarRepository {
  RadarRepositoryImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<Uint8List> getFutureRadar(ZXY zxy, String dateTime) async {
    final response = await apiClient.getFutureRadar(
      dateTime: dateTime,
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }

  @override
  Future<Uint8List> getCloudSatellite(
    ZXY zxy,
    String dateTime, [
    String? displayMode,
  ]) async {
    final response = await apiClient.getCloudSatellite(
      dateTime: dateTime,
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
      displayMode: displayMode ?? '10',
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }

  @override
  Future<Uint8List> getCurrentTemperature(ZXY zxy, String dateTime) async {
    final response = await apiClient.getCurrentTemperature(
      dateTime: dateTime,
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }

  @override
  Future<Uint8List> getRiskTropical(ZXY zxy) async {
    final response = await apiClient.getRiskTropical(
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }

  @override
  Future<Uint8List> getMaximumSustainedWinds(ZXY zxy) async {
    final response = await apiClient.getMaximumSustainedWinds(
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }

  @override
  Future<Uint8List> getRainFallAmounts(ZXY zxy) async {
    final response = await apiClient.getRainFallAmounts(
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }

  @override
  Future<Uint8List> getStormSurge(ZXY zxy) async {
    final response = await apiClient.getStormSurge(
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }

  @override
  Future<Uint8List> getWatchesAndWarnings(ZXY zxy) async {
    final response = await apiClient.getWatchesAndWarnings(
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }

  @override
  Future<Uint8List> getWaterVapor(ZXY zxy, String dateTime) async {
    final response = await apiClient.getWaterVapor(
      dateTime: dateTime,
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }

  @override
  Future<Uint8List> getMaximumWindGusts(ZXY zxy) async {
    final response = await apiClient.getMaximumWindGusts(
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
    );
    final imageBytes = Uint8List.fromList(response);
    return imageBytes;
  }
}
