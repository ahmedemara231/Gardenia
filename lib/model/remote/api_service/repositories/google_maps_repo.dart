import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/service/api_request.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import 'package:multiple_result/multiple_result.dart';
import '../model/google_maps_model.dart';
import '../service/error_handling/errors.dart';

class GoogleMapsRepo
{
  late ApiService googleMapsConnection;
  GoogleMapsRepo({required this.googleMapsConnection});

  Future<Result<MapModel,CustomError>> getSuggestions(String input)async
  {
    Map<String,dynamic> params =
    {
      'input' : input,
      'key' : ApiConstants.apiKey,
    };

   Result<Response,CustomError> suggestionsResponse = await googleMapsConnection.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: 'autocomplete/json',
            queryParams: params,
            withToken: false,
        ),
    );
   return suggestionsResponse.when(
           (success) => Result.success(MapModel.fromJson(suggestionsResponse.getOrThrow().data)),
           (error) => Result.error(suggestionsResponse.tryGetError()!),
   );
  }
}