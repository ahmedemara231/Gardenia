import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gardenia/modules/data_types/update_user_data.dart';
import 'package:multiple_result/multiple_result.dart';
import '../factory_method.dart';
import '../model/model.dart';
import '../service/api_request.dart';
import '../service/constants.dart';
import '../service/error_handling/errors.dart';
import '../service/languages_and_methods.dart';
import '../service/request_models/headers.dart';
import '../service/request_models/request_model.dart';

class PutRepo
{
  ApiService apiService;

  PutRepo({required this.apiService});
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
          headers: HeadersWithToken(contentType: 'multipart/form-data'),
          data: formData
      ),
    );

    return updateProfileImageResponse.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
  }

  Future<Result<Model,CustomError>> editPost({
    required int postId,
    required String newCaption,
})async
  {

    FormData formData = FormData.fromMap({
      '_method' : 'PUT',
      'caption' : newCaption,
    });

    Result<Response,CustomError> updatePostResponse = await apiService.callApi(
        request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.updatePost,
          queryParams: {'post_id' : postId},
          data: formData,
          headers: HeadersWithToken(contentType: 'multipart/form-data'),
        ),
    );

    return updatePostResponse.when(
            (success) => Result.success(Executer().factory(success)),
            (error) => Result.error(error),
    );
  }

  Future<Result<Model,CustomError>> editUserData(UpdateUserData userData)async
  {
    Result<Response,CustomError> updateUserDataResponse = await apiService.callApi(
      request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.updateProfile,
          headers: HeadersWithToken(),
          data: userData.toJson(),
      ),
    );

    return updateUserDataResponse.when(
            (success) => Result.success(Executer().factory(success)),
            (error) => Result.error(error),
    );
  }
}