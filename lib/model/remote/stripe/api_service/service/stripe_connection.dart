import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:gardenia/model/remote/api_service/service/api_request.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
import 'package:gardenia/model/remote/stripe/api_service/constants.dart';
import 'package:multiple_result/src/result.dart';

class StripeConnection extends ApiService
{

  late Dio dio;

  static StripeConnection? instance;
  StripeConnection() :
        dio = Dio()..options.baseUrl = StripeApiConstants.baseUrl
          ..options.connectTimeout = ApiConstants.timeoutDuration
          ..options.receiveTimeout = ApiConstants.timeoutDuration;

  static StripeConnection getInstance()
  {
    return instance ??= StripeConnection();
  }


  @override
  Future<Result<Response, CustomError>> callApi({required RequestModel request})async{
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
                headers: await request.headers!.toJson()
            ),
            data: request.isFormData?
            FormData.fromMap(request.data) : request.data,
            queryParameters: request.queryParams,
            onSendProgress: request.onSendProgress,
            onReceiveProgress: request.onReceiveProgress,
          );

          return Result.success(response);
        }on DioException catch(e)
        {
          // return Result.error(handleErrors(e));

          String prettyJson = const JsonEncoder.withIndent('  ').convert(e.response?.data);
          log(prettyJson);

          return Result.error(CustomError('Error : $e'));
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