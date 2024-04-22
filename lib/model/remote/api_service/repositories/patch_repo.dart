
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/factory_method.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../model/model.dart';
import '../service/api_requests.dart';

class PatchRepo
{
  ApiService apiService;

  PatchRepo({required this.apiService});

  Future<Result<Model,CustomError>> updateProfileImage(File image)async
  {
    FormData formData = FormData.fromMap({
      '_method' : 'PATCH',
      'image' : await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });


    Result<Response,CustomError> updateProfileImageResponse = await apiService.callApi(
      request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.updateProfile,
          withToken: true,
          data: formData
      ),
    );

    return updateProfileImageResponse.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
  }

}
