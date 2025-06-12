import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/entities/one_minute_cast/one_minute_cast.dart';
import 'package:mimemo/services/api/api_client.dart';

abstract class ForecastRepository {
  Future<OneMinuteCast> get1MinuteCast(double lat, double long);

  Future<List<MinuteColor>> getMinuteColors();

  Future<List<HourlyForecast>> getNext12HoursForecast(String locationKey);

  Future<DailyForecast> get10DaysForecast(String locationKey);

  Future<DailyForecast> get15DaysForecast(String locationKey);

  Future<DailyForecast> get45DaysForecast(String locationKey);
}

class ForecastRepositoryImpl extends ForecastRepository {
  ForecastRepositoryImpl({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<OneMinuteCast> get1MinuteCast(double lat, double long) {
    final q = '$lat,$long';

    return apiClient.get1MinuteCast(latLong: q, minuteCount: 240);
  }

  @override
  Future<List<MinuteColor>> getMinuteColors() {
    return apiClient.getMinuteColors();
  }

  @override
  Future<List<HourlyForecast>> getNext12HoursForecast(String locationKey) {
    return apiClient.getNext12HoursForecast(locationKey);
  }

  @override
  Future<DailyForecast> get10DaysForecast(String locationKey) {
    return apiClient.get10DaysForecast(locationKey);
  }

  @override
  Future<DailyForecast> get15DaysForecast(String locationKey) {
    return apiClient.get15DaysForecast(locationKey);
  }

  @override
  Future<DailyForecast> get45DaysForecast(String locationKey) {
    return apiClient.get45DaysForecast(locationKey);
  }
}
