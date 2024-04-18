import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/factory_method.dart';
import 'package:gardenia/model/remote/api_service/model/model.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import 'package:multiple_result/multiple_result.dart';
import '../service/api_requests.dart';

class GetRepo
{
  ApiService? apiService;

  GetRepo({required this.apiService});

  Future<Result<Model,CustomError>> getPosts()async
  {
    Result<Response,CustomError> getPostsResponse = await apiService!.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.getPosts,
            withToken: false
        ),
    );
    if(getPostsResponse.isSuccess())
      {
        return Result.success(Executer().factory(getPostsResponse.getOrThrow()));
      }
    else{
      return Result.error(getPostsResponse.tryGetError()!);
    }
  }

  Future<Result<Model,CustomError>> getCommentsForPost(int postId)async
  {
    Result<Response, CustomError> getCommentsResponse = await apiService!.callApi(
      request: RequestModel(
          method: Methods.GET,
          endPoint: 'posts/$postId/comments',
          withToken: false
      ),
    );
    if(getCommentsResponse.isSuccess())
      {
        return Result.success(Executer().factory(getCommentsResponse.tryGetSuccess()!));
      }
    else{
      return Result.error(getCommentsResponse.tryGetError()!);
    }
  }
}
