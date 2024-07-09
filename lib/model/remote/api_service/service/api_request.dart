import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/download_request_model.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ApiService
{
  Future<Result<Response,CustomError>> callApi({
    required RequestModel request,
  });
}

abstract class DownloadApiService
{
  Future<Result<Response,CustomError>> downloadFromApi({
    required DownloadModel request,
  });
}