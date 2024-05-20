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