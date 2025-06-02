import 'package:dio/dio.dart';
import 'package:mimemo/core/const/config.dart';

class ApiInterceptor extends InterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['apikey'] = Config.apiKey;
    options.queryParameters['detail'] = true;
    options.queryParameters['language'] = 'en-us';
    handler.next(options);
  }
}
