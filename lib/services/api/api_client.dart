import 'package:dio/dio.dart';
import 'package:mimemo/core/const/config.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Config.apiUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  /// Position
  @GET('/locations/v1/cities/geoposition/search')
  Future<PositionInfo> getGeoPosition(@Query('q') String latLong);
}
