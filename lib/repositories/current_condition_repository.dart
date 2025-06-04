import 'package:mimemo/models/entities/current_conditions/current_conditions.dart';
import 'package:mimemo/services/api/api_client.dart';

abstract class CurrentConditionRepository {
  Future<CurrentConditions?> getCurrentConditions(String locationKey);
}

class CurrentConditionRepositoryImpl extends CurrentConditionRepository {
  final ApiClient apiClient;

  CurrentConditionRepositoryImpl({required this.apiClient});

  @override
  Future<CurrentConditions?> getCurrentConditions(String locationKey) async {
    final response =  await apiClient.getCurrentConditions(locationKey);
    final result = response.firstOrNull;
    return result;
  }
}
