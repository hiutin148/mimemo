import 'package:dio/dio.dart';
import 'package:mimemo/core/const/config.dart';
import 'package:mimemo/models/entities/current_air_quality/current_air_quality.dart';
import 'package:mimemo/models/entities/current_conditions/current_conditions.dart';
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

  // Forecast
  @GET('/forecasts/v1/minute/1minute')
  Future<OneMinuteCast> get1MinuteCast(@Query("q") String latLong);

  @GET('/forecasts/v1/minute/colors/simple')
  Future<List<MinuteColor>> getMinuteColors();

  // Current condition
  @GET('/currentconditions/v1/{locationKey}')
  Future<CurrentConditions> getCurrentConditions(@Path("locationKey") String locationKey);

  @GET('/airquality/v2/currentconditions/{locationKey}')
  Future<CurrentAirQuality> getCurrentAirQuality(@Path("locationKey") String locationKey);

}
