import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../modules/data_types/user_data.dart';
import '../factory_method.dart';
import '../model/model.dart';
import '../service/api_request.dart';

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
    return loginResult.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
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
    return signUpResult.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
  }


  Future<Result<Model,CustomError>> forgotPassword(String email)async
  {
    Result<Response,CustomError> forgotPassResponse = await apiService.callApi(
      request: RequestModel(
        method: Methods.POST,
        endPoint: ApiConstants.forgotPassword,
        withToken: false,
        data: {'email' : email},
      ),
    );
    return forgotPassResponse.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
  }


  Future<Result<Model,CustomError>> sendOTPCode({
    required String email,
    required String code,
  })async
  {
    Result<Response,CustomError> sendCodeResponse = await apiService.callApi(
      request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.sendCode,
          withToken: false,
          data:
          {
            'email' : email,
            'otp' : code,
          }
      ),
    );
    return sendCodeResponse.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
  }

  Future<Result<Model,CustomError>> resetPassword({
    required String email,
    required String newPass,
    required String conformNewPass,
  })async
  {
    Result<Response,CustomError> resetPassResponse = await apiService.callApi(
      request: RequestModel(
          method: Methods.POST,
          endPoint: ApiConstants.resetPassword,
          withToken: false,
          data:
          {
            'email' : email,
            'password' : newPass,
            'password_confirm' : conformNewPass
          }
      ),
    );
    return resetPassResponse.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
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
    return response.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
  }


  Future<Result<Model,CustomError>> createPost({
    required String caption,
    required File selectedImage,
    required void Function(int, int)? onSendProgress
})async
  {

    FormData formData = FormData.fromMap({
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
    return createPostResponse.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
  }

  Future<Result<Model,CustomError>> createComment({required int postId,required String comment})async
  {
    Result<Response,CustomError> createCommentResponse = await apiService.callApi(
        request: RequestModel(
          method: Methods.POST,
          withToken: true,
          endPoint: ApiConstants.createComment,
          data:
          {
            'content' : comment,
            'post_id' : postId,
          }
        ),
    );
    return createCommentResponse.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
  }

  Future<void> addRemFavorite(int plantId)async
  {
    await apiService.callApi(
        request: RequestModel(
            method: Methods.POST,
            endPoint: ApiConstants.addRemFavorites,
            queryParams: {'plant_id' : plantId},
            withToken: true
        )).then((result)
    {
      print(result.getOrThrow().data);
    });
  }



}