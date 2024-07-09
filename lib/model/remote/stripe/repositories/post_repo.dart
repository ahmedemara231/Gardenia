import 'package:dio/src/response.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/headers.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
import 'package:gardenia/model/remote/stripe/api_service/constants.dart';
import 'package:gardenia/model/remote/stripe/api_service/models/create_intent_input_model.dart';
import 'package:gardenia/model/remote/stripe/api_service/models/create_intent_model.dart';
import 'package:multiple_result/src/result.dart';
import '../../api_service/service/api_request.dart';

class StripePostRepo {
  late ApiService apiService;

  StripePostRepo({required this.apiService});

  // create payment intent
  Future<Result<CreateIntentModel, CustomError>> createPaymentIntent(
      {required CreateIntentInputModel inputModel}) async {
    Result<Response, CustomError> createIntentResponse =
        await apiService.callApi(
      request: RequestModel(
        method: Methods.POST,
        endPoint: StripeApiConstants.createIntent,
        data: {
          'amount': inputModel.amount,
          'currency': inputModel.currency,
          'customer': inputModel.customerId,
        },
        headers:
            StripeHeaders(contentType: 'application/x-www-form-urlencoded'),
      ),
    );

    if (createIntentResponse.isSuccess()) {
      CreateIntentModel model =
          CreateIntentModel.fromJson(createIntentResponse.getOrThrow().data);
      return Result.success(model);
    } else {
      return Result.error(createIntentResponse.tryGetError()!);
    }
  }

  // create customer
  Future<Result<String, CustomError>> createCustomer({
    required String name,
    required String phone
  }) async {
    Result<Response, CustomError> createCustomerResponse =
        await apiService.callApi(
      request: RequestModel(
        method: Methods.POST,
        endPoint: StripeApiConstants.createCustomer,
        data: {
          'name': name,
          'phone': phone,
        },
        headers:
            StripeHeaders(contentType: 'application/x-www-form-urlencoded'),
      ),
    );

    return createCustomerResponse.when(
            (success) => Result.success(success.data['id']),
            (error) => Result.error(error),
    );
  }

  // create  Ephemeral Key
  Future<Result<String, CustomError>> createEphemeralKey({
    required String name,
    required String phone
  }) async {
    Result<Response, CustomError> createCustomerResponse =
    await apiService.callApi(
      request: RequestModel(
        method: Methods.POST,
        endPoint: StripeApiConstants.getEphemeralKey,
        data: {
          'customer' : 'cus_QRO74OeDrsV4D1'
        },
        headers:
        StripeHeaders(
          contentType: 'application/x-www-form-urlencoded',
          stripeVersion: '2024-06-20'
        ),
      ),
    );

    return createCustomerResponse.when(
          (success) => Result.success(success.data['id']),
          (error) => Result.error(error),
    );
  }
}
