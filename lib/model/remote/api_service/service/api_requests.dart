import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ApiService
{
  Future<Result<Response,CustomError>> callApi({
    required RequestModel request,
  });
}