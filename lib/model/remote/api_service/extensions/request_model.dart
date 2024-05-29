import 'dart:io';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';

extension RequestExtension on RequestModel
{
  void prepareDataForRequest()
  {
    if(data != null)
      {
        for(MapEntry entry in data)
          {
            if(entry.value is File)
              {
                isFormData = true;
                entry.value.toMultiPartFile();
              }
          }
      }
  }
}