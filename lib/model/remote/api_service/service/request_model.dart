import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/extensions/request_model.dart';

class RequestModel
{
  String method;
  String endPoint;
  bool withToken;
  dynamic data;
  bool isFormData;
  Map<String,dynamic>? queryParams;
  ResponseType? responseType;
  void Function(int count, int total)? onSendProgress;
  void Function(int count, int total)? onReceiveProgress;

  RequestModel({
    required this.method,
    required this.endPoint,
    required this.withToken,
    this.data,
    this.queryParams,
    this.responseType,
    this.onSendProgress,
    this.onReceiveProgress,
    this.isFormData = false,
});

  factory RequestModel.getInstance(RequestModel requestModel)
  {
    requestModel.prepareDataForRequest();
    return requestModel;
  }
}