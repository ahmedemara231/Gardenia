import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/service/api_request.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import 'package:gardenia/model/remote/google_maps_service/google_maps_api_constants.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../api_service/service/error_handling/errors.dart';
import '../google_maps_models/autoCompleteModel.dart';
import '../google_maps_models/place_details.dart';
import '../google_maps_models/route_model.dart';


class GoogleMapsRepo
{
  late ApiService googleMapsConnection;
  GoogleMapsRepo({required this.googleMapsConnection});

  Future<Result<AutoCompleteModel,CustomError>> getSuggestions({
    required String input,
    required String sessionToken,
})async
  {
    Map<String,dynamic> params =
    {
      'input' : input,
      'key' : MapsConstants.apiKey,
      'sessiontoken' : sessionToken,
    };

   Result<Response,CustomError> suggestionsResponse = await googleMapsConnection.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: '${MapsConstants.googleMapsPlacesBaseUrl}autocomplete/json',
            queryParams: params,
            withToken: false,
        ),
    );
   return suggestionsResponse.when(
           (success) => Result.success(AutoCompleteModel.fromJson(success.data)),
           (error) => Result.error(error),
   );
  }

  Future<Result<PlaceDetailsModel,CustomError>> getPlaceDetails({
    required String placeId,
    required String sessionToken,
  })async
  {
    final params =
    {
      'key' : MapsConstants.apiKey,
      'place_id' : placeId,
      'sessiontoken' : sessionToken,
    };

    Result<Response,CustomError> placeDetailsResponse = await googleMapsConnection.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: '${MapsConstants.googleMapsPlacesBaseUrl}details/json',
            queryParams: params,
            withToken: false,
        ),
    );

    return placeDetailsResponse.when(
            (success) => Result.success(PlaceDetailsModel.fromJson(success.data)),
            (error) => Result.error(error),
    );
  }

  final getRouteHeaders =
  {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': MapsConstants.apiKey,
    'X-Goog-FieldMask' : 'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
  };

  // Future<Result<List<RouteModel>,CustomError>> getRoute()async
  // {
  //
  //   final getRouteBody =
  //   {
  //     "origin":{
  //       "location":{
  //         "latLng":{
  //           "latitude": originLat,
  //           "longitude": originLng
  //         }
  //       }
  //     },
  //     "destination":{
  //       "location":{
  //         "latLng":{
  //           "latitude": desLat,
  //           "longitude": desLng
  //         }
  //       }
  //     },
  //     "routeModifiers": {
  //       "avoidTolls": false,
  //       "avoidHighways": false,
  //       "avoidFerries": false
  //     },
  //     "travelMode": "DRIVE",
  //     "routingPreference": "TRAFFIC_AWARE",
  //     "computeAlternativeRoutes": false,
  //     "languageCode": "en-US",
  //     "units": "IMPERIAL"
  //   };
  //
  //   Result<Response,CustomError> getRouteResponse = await googleMapsConnection.callApi(
  //     request: RequestModel(
  //         method: Methods.POST,
  //         endPoint: MapsConstants.googleMapsRouteBaseUrl,
  //         data: getRouteBody,
  //         headers: getRouteHeaders,
  //         withToken: false,
  //         responseType: ResponseType.json,
  //       ),
  //   );
  //   final route = getRouteResponse.getOrThrow().data['routes'];
  //
  //
  // }

}