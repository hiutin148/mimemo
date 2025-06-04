import 'package:dio/dio.dart';
import 'package:mimemo/core/const/config.dart';
import 'package:mimemo/services/api/api_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio();
    dio.options.baseUrl = Config.apiUrl;
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 10);
    dio.interceptors.addAll([
      ApiInterceptor(),
    ]);
  }
}
