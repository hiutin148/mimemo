import 'package:dio/dio.dart';
import 'package:mimemo/core/const/config.dart';
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
  }
  late final Dio dio;
}
