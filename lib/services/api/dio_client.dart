import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:mimemo/core/const/config.dart';
import 'package:mimemo/models/entities/search_location_response/search_location_response.dart';
import 'package:mimemo/services/api/api_interceptor.dart';

class DioClient {

  DioClient() {
    dio = Dio();
    dio.options.baseUrl = Config.apiUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.interceptors.addAll([
      ApiInterceptor(),
    ]);
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        return HttpClient(
          context: SecurityContext(),
        )..badCertificateCallback = (cert, host, port) {
          return true;
        };
      },
      validateCertificate: (cert, host, port) {
        return true;
      },
    );
  }
  late final Dio dio;

  Future<SearchLocationResponse?> searchLocation(String query) async {
    final result = await dio.get<dynamic>(
      '${Config.radarLocationUrl}?query=$query&layers=place,street,neighborhood,postalCode,locality&limit=10',
      options: Options(
        headers: {'Authorization': Config.radarLocationKey},
      ),
    );
    if (result.data is Map<String, dynamic>) {
      return SearchLocationResponse.fromJson(result.data as Map<String, dynamic>);
    }
    return null;
  }
}
