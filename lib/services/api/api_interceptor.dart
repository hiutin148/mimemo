import 'package:dio/dio.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/const/config.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['apikey'] = Config.apiKey;
    options.queryParameters['details'] = true;
    options.queryParameters['language'] = 'en-us';
    options.headers['Accept-Encoding'] = 'gzip,deflate';
    // TODO
    options.queryParameters['metric'] = true;
    logger.d(
      'REQUEST[${options.method}] => PATH: ${options.path}\nQUERY: ${options.queryParameters}\nBODY: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger.i('RESPONSE[${response.statusCode}] for ${response.realUri} \n => DATA: ${response.data}');
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
