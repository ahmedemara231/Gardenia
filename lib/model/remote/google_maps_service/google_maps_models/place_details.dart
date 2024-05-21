class PlaceDetailsModel
{
  String status;
  DetailsResult result;

  PlaceDetailsModel({required this.status,required this.result});

  factory PlaceDetailsModel.fromJson(Map<String,dynamic> data)
  {
    return PlaceDetailsModel(
        status: data['status'],
        result: DetailsResult.fromJson(data['result']),
    );
  }

}

class DetailsResult
{
  String name;
  String icon;
  String iconBackgroundColor;
  String url;
  Map<String,dynamic> geometry;
  
  DetailsResult({
    required this.name,
    required this.icon,
    required this.iconBackgroundColor,
    required this.url,
    required this.geometry,
});
  
  factory DetailsResult.fromJson(Map<String,dynamic> detailsResult)
  {
    return DetailsResult(
        name: detailsResult['name'],
        icon: detailsResult['icon'],
        iconBackgroundColor: detailsResult['icon_background_color'],
        url: detailsResult['url'],
        geometry: detailsResult['geometry']
    );
  }
}
/*
* import 'package:gardenia/modules/data_types/google_maps/ori_des_location.dart';

class RouteModel {
  ResultModel result;

  RouteModel({required this.result});

  factory RouteModel.fromJson(Map<String,dynamic> data)
  {
    return RouteModel(result: ResultModel.fromJson(data));
  }
}

class ResultModel {
  String name;
  String place_id;
  String url;
  String icon;
  String icon_background_color;
  Geometry geometry;

  ResultModel({
    required this.name,
    required this.place_id,
    required this.url,
    required this.icon,
    required this.icon_background_color,
    required this.geometry
  });

  factory ResultModel.fromJson(Map<String, dynamic> resultData)
  {
    return ResultModel(
        name: resultData['name'],
        place_id: resultData['place_id'],
        url: resultData['url'],
        icon: resultData['icon'],
        icon_background_color: resultData['icon_background_color'],
        geometry: Geometry.fromJson(resultData['geometry']),
    );
  }

}

class Geometry {
  PlaceLocation placeLocation;

  Geometry({required this.placeLocation});

  factory Geometry.fromJson(Map<String, dynamic> geometryData)
  {
    return Geometry(
      placeLocation: PlaceLocation(
        lat: geometryData['location']['lat'],
        long: geometryData['location']['lng'],
      ),
    );
  }
}*/