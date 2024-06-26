import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor
{
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    String prettyJson = const JsonEncoder.withIndent('  ').convert(err.response?.data);
    log(prettyJson);

    String statusCode = 'status code : ${err.response?.statusCode}';
    String statusMessage = 'status message : ${err.response?.statusMessage}';

    String method = 'Method : ${err.requestOptions.method}';
    String url = 'Url : ${err.requestOptions.baseUrl+err.requestOptions.path}';

    var headers = 'Headers : ${err.requestOptions.headers}';
    var requestData = 'request data : ${err.requestOptions.data}';
    var requestQueryParams = 'request params${err.requestOptions.queryParameters}';

    log(statusCode);
    log(statusMessage);
    log(method);
    log(url);
    log(headers);
    log(requestData);
    log(requestQueryParams);

    handler.next(err);
  }
}