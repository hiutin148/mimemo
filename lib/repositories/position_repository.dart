import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/services/api/api_client.dart';

abstract class PositionRepository {
  Future<PositionInfo> getGeoPosition({required double lat, required double long});

  Future<PositionInfo> getPositionByLocationKey(String locationKey);
}

class PositionRepositoryImpl extends PositionRepository {
  PositionRepositoryImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<PositionInfo> getGeoPosition({required double lat, required double long}) {
    final q = '$lat,$long';
    return apiClient.getGeoPosition(q);
  }

  @override
  Future<PositionInfo> getPositionByLocationKey(String locationKey) {
    return apiClient.getPositionByLocationKey(locationKey);
  }
}
