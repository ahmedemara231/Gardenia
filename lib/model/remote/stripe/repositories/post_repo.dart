import 'package:dio/src/response.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/headers.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
import 'package:gardenia/model/remote/stripe/api_service/constants.dart';
import 'package:gardenia/model/remote/stripe/api_service/models/create_intent_model.dart';
import 'package:multiple_result/src/result.dart';
import '../../api_service/service/api_request.dart';

class StripePostRepo
{
  late ApiService apiService;

  StripePostRepo({required this.apiService});

  // create payment intent
  Future<Result<CreateIntentModel, CustomError>> createPaymentIntent({
    required String amount,
    required String currency
  })async {
    Result<Response,CustomError> createIntentResponse = await apiService.callApi(
      request: RequestModel(
        method: Methods.POST,
        endPoint: StripeApiConstants.createIntent,
        data:
        {
          'amount' : amount,
          'currency' : currency
        },
        headers: StripeHeaders(contentType: 'application/x-www-form-urlencoded'),
      ),
    );

    if(createIntentResponse.isSuccess())
      {
        CreateIntentModel model = CreateIntentModel.fromJson(createIntentResponse.getOrThrow().data);
        return Result.success(model);
      }
    else{
      return Result.error(createIntentResponse.tryGetError()!);
    }
  }
}