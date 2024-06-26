class MapsRequestModel
{
  String method;
  String endPoint;
  Map<String,dynamic>? headers;
  dynamic data;
  Map<String,dynamic>? queryParams;

  MapsRequestModel({
    required this.method,
    required this.endPoint,
    this.headers,
    this.data,
    this.queryParams,
  });
}

