import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/service/api_request.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/interceptors/bad_response.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/interceptors/logger.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/interceptors/timeout.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/download_request_model.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
import 'package:multiple_result/multiple_result.dart';
import '../error_handling/handle_errors.dart';

class DioConnection extends ApiService implements DownloadApiService
{

  DioConnection()
  {
    _initDio();
  }

  late Dio dio;
  late Dio dioForDownload;

  void _initDio()
  {
    dio = Dio()
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = ApiConstants.timeoutDuration
      ..options.receiveTimeout = ApiConstants.timeoutDuration;

    List<Interceptor> myInterceptors =
    [
      LoggerInterceptor(),
      TimeoutInterceptor(dio),
      BadResponseInterceptor(dio),
    ];

    dio.interceptors.addAll(myInterceptors);

    dioForDownload = Dio();
  }
  static DioConnection? dioHelper;

  static DioConnection getInstance()
  {
    return dioHelper ??= DioConnection();
  }


  // Future<Map<String,dynamic>> _getHeaders(bool withToken, {String? lang})async
  // {
  //   Map<String, dynamic> headers = {};
  //
  //   headers[HttpHeaders.acceptHeader] = 'application/json';
  //   headers[HttpHeaders.contentTypeHeader] = 'application/json';
  //
  //   if(withToken)
  //   {
  //     String token = await _getToken;
  //     headers[HttpHeaders.authorizationHeader] = token;
  //   }
  //   else{
  //     headers.remove(HttpHeaders.authorizationHeader);
  //   }
  //   return headers;
  // }
  //
  // Future<String> get _getToken async
  // {
  //   String? token = await SecureStorage.getInstance().readData(key: 'userToken');
  //   String fullToken = 'Bearer $token';
  //   return fullToken;
  // }

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
              headers: await request.headers?.toJson()
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

  @override
  Future<Result<Response, CustomError>> downloadFromApi({
    required DownloadModel request
  }) async
  {
    try{
      Response response = await dioForDownload.download(
        request.urlPath,
        request.savePath,
        onReceiveProgress: request.onReceiveProgress,
        options: Options(
            responseType: ResponseType.bytes
        ),
      );
      log('res data is ${response.data}');
      return Result.success(response);
    }on DioException catch(e)
    {
      return Result.error(handleErrors(e));
    }

  }
}
