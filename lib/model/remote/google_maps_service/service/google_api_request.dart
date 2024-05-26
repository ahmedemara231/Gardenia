import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../api_service/service/request_model.dart';
import '../error_handling/errors.dart';

abstract class GoogleApiService
{
  Future<Result<Response,GoogleMapsError>> callGoogleApi({
    required RequestModel request,
  });
}