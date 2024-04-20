import 'package:dio/dio.dart';
import 'package:gardenia/model/remote/api_service/factory_method.dart';
import 'package:gardenia/model/remote/api_service/model/model.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import 'package:gardenia/modules/data_types/plant.dart';
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
          endPoint: ApiConstants.getComments,
          queryParams: {'post_id' : postId},
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

  Future<Result<List<Plant>,CustomError>> getAllCategories()async
  {
    Result<Response, CustomError> getAllCategoriesRes = await apiService!.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.allCategories,
            withToken: false,
        ),
    );
    if(getAllCategoriesRes.isSuccess())
      {
        return Result.success((getAllCategoriesRes.tryGetSuccess()!.data['data']['plants'] as List).map((e) => Plant(
            id: e['id'],
            name: e['name'],
            image: e['image'],
            description: e['description'],
            type: e['type'],
            light: e['light'],
            ideal_temperature: e['ideal_temperature'],
            resistance_zone: e['resistance_zone'],
            suitable_location: e['suitable_location'],
            careful: e['careful'],
            liquid_fertilizer: e['liquid_fertilizer'],
            clean: e['clean'],
            toxicity: e['toxicity'],
            names: e['names']
        )).toList());
      }
    else{
      return Result.error(getAllCategoriesRes.tryGetError()!);
    }
  }
}
