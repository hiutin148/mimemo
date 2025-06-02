import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/services/api/api_client.dart';

abstract class PositionRepository {
  Future<PositionInfo> getGeoPosition({required double lat, required double long});
}

class PositionRepositoryImpl extends PositionRepository {
  final ApiClient apiClient;

  PositionRepositoryImpl({required this.apiClient});

  @override
  Future<PositionInfo> getGeoPosition({required double lat, required double long}) {
    final q = '$lat,$long';
    return apiClient.getGeoPosition(q);
  }
}
