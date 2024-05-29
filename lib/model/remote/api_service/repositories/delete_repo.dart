import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/factory_method.dart';
import 'package:gardenia/model/remote/api_service/service/api_request.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
import 'package:multiple_result/multiple_result.dart';
import '../model/model.dart';

class DeleteRepo
{
  ApiService? apiService;
  
  DeleteRepo({required this.apiService});
  
  Future<Result<Model,CustomError>> deletePost(int postId)async
  {
    Result<Response, CustomError> deletePostResponse = await apiService!.callApi(
        request: RequestModel(
          method: Methods.DELETE,
          endPoint: ApiConstants.deletePost,
          queryParams: { 'post_id' : postId },
          withToken: false,
        ),
    );
    if(deletePostResponse.isSuccess())
      {
        return Result.success(Executer().factory(deletePostResponse.getOrThrow()));
      }
    else{
      return Result.error(deletePostResponse.tryGetError()!);
    }
  }

  Future<Result<Model,CustomError>> deleteComment({
    required int postId,
    required int commentId,
})async
  {
    Result<Response, CustomError> deleteCommentResponse = await apiService!.callApi(
      request: RequestModel(
        method: Methods.DELETE,
        endPoint: ApiConstants.deleteComment,
        queryParams:
        {
          'post_id' : postId,
          'comment_id' : commentId
        },
        withToken: true,
      ),
    );
    if(deleteCommentResponse.isSuccess())
    {
      return Result.success(Executer().factory(deleteCommentResponse.getOrThrow()));
    }
    else{
      return Result.error(deleteCommentResponse.tryGetError()!);
    }
  }
  
}