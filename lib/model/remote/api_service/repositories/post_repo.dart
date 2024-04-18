import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../modules/data_types/user_data.dart';
import '../factory_method.dart';
import '../model/model.dart';
import '../service/api_requests.dart';


enum Operation {logout , refresh}

class PostRepo
{
  ApiService apiService;

  PostRepo({required this.apiService});

  Future<Result<Model,CustomError>> login({
    required String email,
    required String password,
})async
  {
    Result<Response, CustomError> loginResult = await apiService.callApi(
      request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.login,
          data:
          {
            'email' : email,
            'password' : password,
          },
          withToken: false
      ),
    );
    if(loginResult.isSuccess())
      {
        return Result.success(Executer().factory(loginResult.getOrThrow()));
      }
    else{
      return Result.error(loginResult.tryGetError()!);
    }
  }

  Future<Result<Model,CustomError>> signUp(UserData user)async
  {
    Result<Response, CustomError> signUpResult = await apiService.callApi(
      request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.signUp,
          data:
          {
            'username' : user.name,
            'email' : user.email,
            'password' : user.password,
            'password_confirm' : user.conformPass,
          },
          withToken: false
      ),
    );
    if(signUpResult.isSuccess())
      {
        return Result.success(Executer().factory(signUpResult.getOrThrow()));
      }
    else{
      return Result.error(signUpResult.tryGetError()!);
    }
  }

  Future<Result<Model,CustomError>> refreshOrLogout({required Operation operation}) async
  {
    Result<Response,CustomError> response = await apiService.callApi(
      request: RequestModel(
          method: Methods.POST,
          endPoint:
          operation == Operation.logout?
          ApiConstants.logout :
          ApiConstants.refreshToken,
          withToken: true
      ),
    );
    if(response.isSuccess())
      {
        return Result.success(Executer().factory(response.getOrThrow()));
      }
    else{
      return Result.error(response.tryGetError()!);
    }
  }


  Future<Result<Model,CustomError>> createPost({
    required String caption,
    required File selectedImage,
    required void Function(int, int)? onSendProgress
})async
  {

    FormData formData = FormData.fromMap({
      'user_id' : (await CacheHelper.getInstance().getData('userData') as List)[0],
      'caption': caption,
      'image': await MultipartFile.fromFile(
        selectedImage.path,
        filename: selectedImage.path.split('/').last,
      )
    });

    Result<Response,CustomError> createPostResponse = await apiService.callApi(
      request: RequestModel(
        method: Methods.POST,
        endPoint: ApiConstants.createPost,
        withToken: true,
        data: formData,
        onSendProgress: onSendProgress
      ),
    );
    if(createPostResponse.isSuccess())
    {
      return Result.success(Executer().factory(createPostResponse.getOrThrow()));
    }
    else{
      return Result.error(createPostResponse.tryGetError()!);
    }
  }

  Future<Result<Model,CustomError>> createComment({required int postId,required String comment})async
  {
    Result<Response,CustomError> createCommentResponse = await apiService.callApi(
        request: RequestModel(
          method: Methods.POST,
          withToken: true,
          endPoint: 'posts/$postId/comments',
          data:
          {
            'content' : comment,
            'user_id' : CacheHelper.getInstance().sharedPreferences.getStringList('userData')![0].toInt(),
            'post_id' : postId,
          }
        ),
    );
    if(createCommentResponse.isSuccess())
      {
        return Result.success(Executer().factory(createCommentResponse.getOrThrow()));
      }
    else{
      return Result.error(createCommentResponse.tryGetError()!);
    }
  }

}