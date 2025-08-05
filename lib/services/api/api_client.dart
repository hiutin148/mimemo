import 'package:dio/dio.dart';
import 'package:mimemo/core/const/config.dart';
import 'package:mimemo/models/entities/climo_summary/climo_summary.dart';
import 'package:mimemo/models/entities/current_air_quality/current_air_quality.dart';
import 'package:mimemo/models/entities/current_conditions/current_conditions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/entities/one_minute_cast/one_minute_cast.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Config.apiUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  // Location
  @GET('/locations/v1/cities/geoposition/search')
  Future<PositionInfo> getGeoPosition(@Query('q') String latLong);

  @GET('/locations/v1/{locationKey}')
  Future<PositionInfo> getPositionByLocationKey(@Path('locationKey') String locationKey);

  // Forecast
  @GET('/forecasts/v1/minute/1minute')
  Future<OneMinuteCast> get1MinuteCast({
    @Query('q') required String latLong,
    @Query('minuteCount') int? minuteCount,
  });

  @GET('/forecasts/v1/minute/colors/simple')
  Future<List<MinuteColor>> getMinuteColors();

  @GET('/forecasts/v1/hourly/12hour/{locationKey}')
  Future<List<HourlyForecast>> getNext12HoursForecast(@Path('locationKey') String locationKey);

  @GET('/forecasts/v1/hourly/240hour/{locationKey}')
  Future<List<HourlyForecast>> getNext240HoursForecast(@Path('locationKey') String locationKey);

  @GET('/forecasts/v1/daily/10day/{locationKey}')
  Future<DailyForecast> get10DaysForecast(@Path('locationKey') String locationKey);

  @GET('/forecasts/v1/daily/15day/{locationKey}')
  Future<DailyForecast> get15DaysForecast(@Path('locationKey') String locationKey);

  @GET('/forecasts/v1/daily/45day/{locationKey}')
  Future<DailyForecast> get45DaysForecast(@Path('locationKey') String locationKey);

  @GET('/climo/v1/summary/{year}/{month}/{day}/{locationKey}')
  Future<ClimoSummary> getClimoSummary({
    @Path('locationKey') required String locationKey,
    @Path('year') required String year,
    @Path('month') required String month,
    @Path('day') required String day,
  });

  // Current condition
  @GET('/currentconditions/v1/{locationKey}')
  Future<List<CurrentConditions>> getCurrentConditions(@Path('locationKey') String locationKey);

  @GET('/airquality/v2/currentconditions/{locationKey}')
  Future<CurrentAirQuality> getCurrentAirQuality(
    @Path('locationKey') String locationKey, {
    @Query('pollutants') String pollutants = 'true',
  });
}
