import 'dart:developer';
import 'package:dio/dio.dart';

int count = 0;
int maxTries = 3;

class TimeoutInterceptor extends InterceptorsWrapper
{
  Dio dio;
  TimeoutInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler)async {
    {
      if(err.type == DioExceptionType.sendTimeout ||
          err.type == DioExceptionType.connectionTimeout ||
          err.type == DioExceptionType.receiveTimeout ||
          err.type == DioExceptionType.connectionError)
      {
        log('$maxTries');

        if(count < maxTries)
        {
          count++;
          log('$count');
          final options = RequestOptions(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            baseUrl: err.requestOptions.baseUrl,
            path: err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          await _reRequest(options: options, handler: handler);
        }
        else{
          handler.reject(err);
          count = 0;
          log('count is $count');
        }
      }
      else{
        handler.next(err);
      }
    }
  }
  Future<void> _reRequest({
    required RequestOptions options,
    required ErrorInterceptorHandler handler,
  })async
  {
    await dio.request(
        options.path,
        options: Options(
          method: options.method,
          headers: options.headers,
        ),
      data: options.data,
      queryParameters: options.queryParameters
    ).then((newResponse)
    {
      handler.resolve(newResponse);
      count = 0;
    }).catchError((error){handler.reject(error);});
  }
}

