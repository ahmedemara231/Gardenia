import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
import 'package:gardenia/model/remote/google_maps_service/error_handling/errors.dart';
import 'package:gardenia/model/remote/google_maps_service/service/google_api_request.dart';
import 'package:gardenia/model/remote/google_maps_service/service/google_maps_api_constants.dart';
import 'package:gardenia/modules/data_types/google_maps/ori_des_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multiple_result/multiple_result.dart';
import '../google_maps_models/route_model.dart';

class GoogleMapsRepo
{
  late GoogleApiService googleMapsConnection;
  GoogleMapsRepo({required this.googleMapsConnection});


  final getRouteHeaders =
  {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': MapsConstants.apiKey,
    'X-Goog-FieldMask' : 'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
  };

  Future<Result<List<LatLng>,GoogleMapsError>> getRoute({
    required PlaceLocation originLocation,
    required PlaceLocation desLocation,
})async
  {
    final getRouteBody =
    {
      "origin":{
        "location":{
          "latLng":{
            "latitude": originLocation.lat,
            "longitude": originLocation.long
          }
        }
      },
      "destination":{
        "location":{
          "latLng":{
            "latitude": desLocation.lat,
            "longitude": desLocation.long,
          }
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    Result<Response,GoogleMapsError> getRouteResponse = await googleMapsConnection.callGoogleApi(
      request: RequestModel(
          method: Methods.POST,
          endPoint: MapsConstants.googleMapsRouteBaseUrl,
          data: getRouteBody,
          headers: getRouteHeaders,
          withToken: false,
        ),
    );

    if(getRouteResponse.isSuccess())
      {
        final List route = getRouteResponse.getOrThrow().data['routes'];
        List<RouteModel> routeList = route.map((e) => RouteModel.fromJson(e)).toList();

        PolylinePoints polylinePoints = PolylinePoints();
        List<PointLatLng> result = polylinePoints.decodePolyline(routeList.first.polyline['encodedPolyline'] as String);
        List<LatLng> points = result.map((e) => LatLng(e.latitude, e.longitude)).toList();

        return Result.success(points);
      }
    else{
      return Result.error(getRouteResponse.tryGetError()!);
    }
  }

}