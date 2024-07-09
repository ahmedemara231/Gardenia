// import 'package:dio/src/response.dart';
// import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
// import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
// import 'package:gardenia/model/remote/api_service/service/request_models/headers.dart';
// import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
// import 'package:gardenia/model/remote/stripe/api_service/constants.dart';
// import 'package:gardenia/model/remote/stripe/api_service/models/service/stripe_connection.dart';
// import 'package:gardenia/model/remote/stripe/stripe_service/services.dart';
// import 'package:multiple_result/src/result.dart';
//
// class StripeServicesImpl extends StripeServices
// {
//   @override
//   Future<Result<Response, CustomError>> createPaymentIntent({
//     required String amount,
//     required String currency
//   })async {
//     Result<Response,CustomError> response = await StripeConnection.getInstance().callApi(
//         request: RequestModel(
//             method: Methods.POST,
//             endPoint: StripeApiConstants.createIntent,
//             headers: StripeHeaders(contentType: 'application/x-www-form-urlencoded'),
//         ),
//     );
//   }
// }