import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/entities/one_minute_cast/one_minute_cast.dart';
import 'package:mimemo/services/api/api_client.dart';

abstract class ForecastRepository {
  Future<OneMinuteCast> get1MinuteCast(double lat, double long);

  Future<List<MinuteColor>> getMinuteColors();
}

class ForecastRepositoryImpl extends ForecastRepository {
  final ApiClient apiClient;

  ForecastRepositoryImpl({required this.apiClient});

  @override
  Future<OneMinuteCast> get1MinuteCast(double lat, double long) {
    final q = '$lat,$long';

    return apiClient.get1MinuteCast(q);
  }

  @override
  Future<List<MinuteColor>> getMinuteColors() {
    return apiClient.getMinuteColors();
  }
}
