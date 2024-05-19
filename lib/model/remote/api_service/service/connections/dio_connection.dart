import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:gardenia/model/local/flutter_secure_storage.dart';
import 'package:gardenia/model/remote/api_service/service/api_request.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/interceptors/bad_response.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/interceptors/timeout.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/interceptors/unknown.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../error_handling/handle_errors.dart';

class DioConnection implements ApiService
{
  late Dio dio;

  DioConnection()
  {
    dio = Dio()
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = ApiConstants.timeoutDuration
      ..options.receiveTimeout = ApiConstants.timeoutDuration;

        List<InterceptorsWrapper> myInterceptors =
        [
          UnknownErrorInterceptor(),
          TimeoutInterceptor(dio),
          BadResponseInterceptor(dio),
        ];

        dio.interceptors.addAll(myInterceptors);
  }

  static DioConnection? dioHelper;

  static DioConnection getInstance()
  {
    return dioHelper ??= DioConnection();
  }


  Future<Map<String,dynamic>> _getHeaders(bool withToken, {String? lang})async
  {
    Map<String, dynamic> headers = {};

    headers[HttpHeaders.acceptHeader] = 'application/json';
    // headers['Content-Type'] = 'application/json';

    if(withToken)
    {
      String token = await _getToken;
      headers[HttpHeaders.authorizationHeader] = token;
    }
    else{
      headers.remove(HttpHeaders.authorizationHeader);
    }
    return headers;
  }

  Future<String> get _getToken async
  {
    String? token = await SecureStorage.getInstance().readData(key: 'userToken');
    String fullToken = 'Bearer $token';
    return fullToken;
  }

  final cancelRequest = CancelToken();

  void cancelApiRequest()
  {
      cancelRequest.cancel('canceled');
  }


  @override
  Future<Result<Response,CustomError>> callApi({
    required RequestModel request
  }) async
  {
    final connectivityResult = await Connectivity().checkConnectivity();

    switch(connectivityResult)
    {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.vpn:
        try{
          final Response response = await dio.request(
            request.endPoint,
            options: Options(
              receiveDataWhenStatusError: true,
              responseType: request.responseType?? ResponseType.json,
              method: request.method,
              headers: await _getHeaders(request.withToken),
            ),
            data: request.isFormData?
            FormData.fromMap(request.data) : request.data,
            queryParameters: request.queryParams,
            onSendProgress: request.onSendProgress,
            onReceiveProgress: request.onReceiveProgress,
            cancelToken: cancelRequest,
          );

          // String prettyJson = const JsonEncoder.withIndent('  ').convert(response.data);
          // log(prettyJson);

          return Result.success(response);
        }on DioException catch(e)
        {
          return Result.error(handleErrors(e));
        }
        case ConnectivityResult.none:
        default:
          return Result.error(
              NetworkError(
                  'Please check the internet and try again'
              ),
          );
    }
  }
}