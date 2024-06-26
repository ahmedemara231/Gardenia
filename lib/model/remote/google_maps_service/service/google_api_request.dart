import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/maps_request_model.dart';
import 'package:multiple_result/multiple_result.dart';
import '../error_handling/errors.dart';

abstract class GoogleApiService
{
  Future<Result<Response,GoogleMapsError>> callGoogleApi({
    required MapsRequestModel request,
  });
}