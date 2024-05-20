import 'package:dio/dio.dart';

class MapsRequestModel
{
  String method;
  String endPoint;
  bool withToken;
  Map<String,dynamic>? headers;
  dynamic data;
  bool isFormData;
  Map<String,dynamic>? queryParams;
  ResponseType? responseType;
  void Function(int count, int total)? onSendProgress;
  void Function(int count, int total)? onReceiveProgress;

  MapsRequestModel({
    required this.method,
    required this.endPoint,
    required this.withToken,
    this.headers,
    this.data,
    this.queryParams,
    this.responseType,
    this.onSendProgress,
    this.onReceiveProgress,
    this.isFormData = false,
  });
}