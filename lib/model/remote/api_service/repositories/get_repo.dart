import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/factory_method.dart';
import 'package:gardenia/model/remote/api_service/model/model.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/download_request_model.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/headers.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/request_model.dart';
import 'package:gardenia/modules/data_types/comment.dart';
import 'package:gardenia/modules/data_types/plant.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../modules/data_types/post.dart';
import '../service/api_request.dart';

class GetRepo
{
  ApiService apiService;

  GetRepo({required this.apiService});

  Future<Result<List<PostData2>,CustomError>> getPosts()async
  {
    Result<Response,CustomError> getPostsResponse = await apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.getPosts,
            headers: HeadersWithoutToken()
        ),
    );
    return getPostsResponse.when(
          (success) => Result.success(
              (getPostsResponse.getOrThrow().data['data']['posts'] as List).map((e) => PostData2.fromJson(e)).toList()),
          (error) => Result.error(error),
    );
  }

  Future<Result<Uint8List,CustomError>> downloadPostImage(DownloadModel request)async
  {
    Result<Response,CustomError> downloadImageResponse = await apiService.downloadFromApi(
        request: request,
    );
    return downloadImageResponse.when(
            (success) => Result.success(success.data),
            (error) => Result.error(error),
    );
  }
  
  Future<Result<List<Comment>,CustomError>> getCommentsForPost(int postId)async
  {
    Result<Response, CustomError> getCommentsResponse = await apiService.callApi(
      request: RequestModel(
          method: Methods.GET,
          endPoint: ApiConstants.getComments,
          queryParams: {'post_id' : postId},
          headers: HeadersWithoutToken()
      ),
    );
    return getCommentsResponse.when(
          (success) => Result.success(
              (getCommentsResponse.getOrThrow().data['data']['comments'] as List).map(
                      (e) => Comment.fromJson(e)).toList(),
          ),
          (error) => Result.error(error),
    );
  }

  Future<Result<List<Plant>,CustomError>> getAllCategories()async
  {
    Result<Response, CustomError> getAllCategoriesRes = await apiService
        .callApi(
      request: RequestModel(
        method: Methods.GET,
        endPoint: ApiConstants.allCategories,
          headers: HeadersWithoutToken()
      ),
    );

    return getAllCategoriesRes.when(
          (success) =>
          Result.success(
            (getAllCategoriesRes.tryGetSuccess()!.data['data']['plants'] as List)
                .map(
                  (e) => Plant.fromJson(e)
            ).toList(),
          ),
          (error) => Result.error(error),
    );
  }

  Future<Result<List<Plant>,CustomError>> getPopularPlants()async
  {
    Result<Response, CustomError> getPopularPlantsRes = await apiService.callApi(
      request: RequestModel(
        method: Methods.GET,
        endPoint: ApiConstants.popularPlants,
          headers: HeadersWithoutToken()
      ),
    );

    return getPopularPlantsRes.when(
          (success) =>
          Result.success((getPopularPlantsRes.tryGetSuccess()!
              .data['data'] as List).map((e) =>
              Plant.fromJson(e)).toList()),
          (error) => Result.error(error),
    );
  }

  Future<Result<List<Plant>,CustomError>> getSpecificPlantsByCategory(int id)async
  {
    Result<Response, CustomError> getCategoryPlansRes = await apiService.callApi(
      request: RequestModel(
        method: Methods.GET,
        endPoint: ApiConstants.plantsByCategory,
        queryParams: {'category_id' : id},
          headers: HeadersWithoutToken()
      ),
    );

    return getCategoryPlansRes.when(
            (success) => Result.success(
                (success.data['data'] as List).map((e) => Plant.fromJson(e)).toList()
            ),
            (error) => Result.error(error),
    );
  }

  Future<Result<Model,CustomError>> getProfileData()async
  {
    Result<Response, CustomError> profileDataResponse = await apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.getProfileData,
            queryParams:
            {
              'user_id' :
              CacheHelper.getInstance().getUserData()![0].toInt(),
            },
            headers: HeadersWithoutToken()
        ),
    );
   return profileDataResponse.when(
           (success) => Result.success(Executer().factory(success)),
           (error) => Result.error(error),
   );
  }

  Future<Result<List<Plant>,CustomError>> getFavPlants()async
  {
    Result<Response,CustomError> getFav = await apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.getFavPlants,
            headers: HeadersWithToken()
        ),
    );

    if(getFav.isSuccess())
      {
        List<Plant> favList = (getFav.getOrThrow().data['data'] as List).map(
                (e) => Plant.fromJson(e)
        ).toList();
        return Result.success(favList);
      }
    else{
      return Result.error(getFav.tryGetError()!);
    }
  }

}
