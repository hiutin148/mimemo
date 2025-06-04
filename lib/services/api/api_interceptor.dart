import 'package:dio/dio.dart';
import 'package:mimemo/core/const/config.dart';

import '../../common/utils/logger.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['apikey'] = Config.apiKey;
    options.queryParameters['details'] = true;
    options.queryParameters['language'] = 'en-us';
    options.queryParameters['Accept-Encoding'] = 'gzip,deflate';
    logger.d(
      'REQUEST[${options.method}] => PATH: ${options.path}\nQUERY: ${options.queryParameters}\nBODY: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      'ERROR[${err.response?.statusCode}] ${err.requestOptions.path} => MESSAGE: ${err.message} ${err.response}',
      error: err,
    );

    return handler.next(err);
  }
}
