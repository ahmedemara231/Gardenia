import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/service/api_request.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import '../model/google_maps_model.dart';

class GoogleMapsRepo
{

  late final Dio dio = Dio()
    ..options.baseUrl = baseUrlForMaps
    ..options.sendTimeout = const Duration(seconds: 10)
    ..options.receiveTimeout = const Duration(seconds: 10);

  String apiKey = 'AIzaSyCSNqKNa1x4sMId5ouQ08JUX88npwSUl7U';
  String baseUrlForMaps = 'https://maps.googleapis.com/maps/api/place/';

  Future<MapModel> getSuggestions(String input)async
  {
    Map<String,dynamic> params =
    {
      'input' : input,
      'key' : apiKey,
    };
    Response response = await dio.request(
      '${baseUrlForMaps}autocomplete/json?parameters',
      options: Options(method: Methods.GET,responseType: ResponseType.json),
      queryParameters: params
    );

    print(response.data);
    return MapModel.fromJson(response.data);
  }
}