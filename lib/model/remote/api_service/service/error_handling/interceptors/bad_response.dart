import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gardenia/model/local/flutter_secure_storage.dart';
import 'package:gardenia/model/remote/api_service/repositories/post_repo.dart';
import 'package:gardenia/model/remote/api_service/service/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import '../../languages_and_methods.dart';

class BadResponseInterceptor extends InterceptorsWrapper
{
  Dio dio;
  BadResponseInterceptor(this.dio);

  Future<Map<String,dynamic>> _getHeaders(bool withToken, {String? lang})async
  {
    Map<String, dynamic> headers = {};

    // headers[HttpHeaders.acceptHeader] = ContentType.json;

    headers['accept'] = 'application/json';
    headers['Content-Type'] = 'application/json';
    headers['lang'] = lang?? Languages.english;

    if(withToken)
    {
      String token = await _getToken();
      headers[HttpHeaders.authorizationHeader] = token;
    }
    else{
      headers.remove(HttpHeaders.authorizationHeader);
    }
    return headers;
  }

  Future<String> _getToken()async
  {
    String? token = await SecureStorage.getInstance().readData(key: 'userToken');
    String fullToken = 'Bearer $token';
    return fullToken;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler)async {

    log(err.type.name);

    if(err.type == DioExceptionType.badResponse)
      {
        String requestMethod = 'The request method is ${err.requestOptions.method}';
        String requestPath = 'The request path is ${err.requestOptions.baseUrl}${err.requestOptions.path}';
        String requestHeaders = 'The request headers are ${err.requestOptions.headers}';

        log(requestMethod);
        log(requestHeaders);
        log(requestPath);

        switch(err.response?.statusCode)
        {
          case 400:
            // bad request
          case 401:
            log(err.response!.statusMessage!);
            await _refreshToken();
            await _reRequest(
                RequestModel(
                    method: err.requestOptions.method,
                    endPoint: err.requestOptions.path,
                    withToken: true,
                ), handler,
            );

          default:
            handler.reject(err);
        }
      }
    else{
      handler.next(err);
    }
  }

  Future<void> _refreshToken() async
  {
    await dio.post(
      'refresh',
      options: Options(
        headers: await _getHeaders(true),
      )
    ).then((newResponse)
    {

    });
  }

  Future<void> _reRequest(RequestModel oldRequest,ErrorInterceptorHandler handler)async
  {
    log('re request');
    await dio.request(
      oldRequest.endPoint,
      options: Options(
        headers: await _getHeaders(oldRequest.withToken),
        method: oldRequest.method,
      ),
      data: oldRequest.data,
      queryParameters: oldRequest.queryParams,
    ).then((newResponse)
    {
      handler.resolve(newResponse);
    }).catchError((error){handler.reject(error);});
  }
}