import 'package:mimemo/models/entities/current_air_quality/current_air_quality.dart';
import 'package:mimemo/models/entities/current_conditions/current_conditions.dart';
import 'package:mimemo/services/api/api_client.dart';

abstract class CurrentConditionRepository {
  Future<CurrentConditions?> getCurrentConditions(String locationKey);

  Future<CurrentAirQuality?> getCurrentAirQuality(String locationKey);
}

class CurrentConditionRepositoryImpl extends CurrentConditionRepository {
  CurrentConditionRepositoryImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<CurrentConditions?> getCurrentConditions(String locationKey) async {
    final response = await apiClient.getCurrentConditions(locationKey);
    final result = response.firstOrNull;
    return result;
  }

  @override
  Future<CurrentAirQuality?> getCurrentAirQuality(String locationKey) {
    return apiClient.getCurrentAirQuality(locationKey);
  }
}
