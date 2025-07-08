import 'dart:typed_data';

import 'package:mimemo/models/entities/zxy/zxy.dart';
import 'package:mimemo/services/api/api_client.dart';

abstract class RadarRepository {
  Future<Uint8List> getFutureRadar(ZXY zxy, String dateTime);

  Future<Uint8List> getCloudSatellite(ZXY zxy, String dateTime);

  Future<Uint8List> getCurrentTemperature(ZXY zxy, String dateTime);
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
  Future<Uint8List> getCloudSatellite(ZXY zxy, String dateTime) async {
    final response = await apiClient.getCloudSatellite(
      dateTime: dateTime,
      z: zxy.z,
      x: zxy.x,
      y: zxy.y,
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
}
