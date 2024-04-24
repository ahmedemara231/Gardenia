import 'dart:io';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import '../factory_method.dart';
import '../model/model.dart';
import '../service/api_requests.dart';
import '../service/constants.dart';
import '../service/error_handling/errors.dart';
import '../service/languages_and_methods.dart';
import '../service/request_model.dart';

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
          withToken: true,
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
    // required File image,
})async
  {

    FormData formData = FormData.fromMap({
      '_method' : 'PUT',
      'caption' : newCaption,
      // 'image' : await MultipartFile.fromFile(image.path),
    });

    Result<Response,CustomError> updatePostResponse = await apiService.callApi(
        request: RequestModel(
            method: Methods.POST,
            endPoint: ApiConstants.updatePost,
            queryParams: {'post_id' : postId},
            data: formData,
            withToken: true
        ),
    );

    return updatePostResponse.when(
            (success) => Result.success(Executer().factory(success)),
            (error) => Result.error(error),
    );
  }
}