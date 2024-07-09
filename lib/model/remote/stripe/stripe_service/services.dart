import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class StripeServices
{
  Future<Result<Response,CustomError>> createPaymentIntent({
    required String amount,
    required String currency
  });
}