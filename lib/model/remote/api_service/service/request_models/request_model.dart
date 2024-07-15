import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/extensions/request_model.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/headers.dart';

class RequestModel
{
  String method;
  String endPoint;
  RequestHeaders? headers;
  dynamic data;
  bool isFormData;
  Map<String,dynamic>? queryParams;
  ResponseType? responseType;
  void Function(int count, int total)? onSendProgress;
  void Function(int count, int total)? onReceiveProgress;

  RequestModel({
    required this.method,
    required this.endPoint,
    this.headers,
    this.data,
    this.queryParams,
    this.responseType,
    this.onSendProgress,
    this.onReceiveProgress,
    this.isFormData = false,
});
}

