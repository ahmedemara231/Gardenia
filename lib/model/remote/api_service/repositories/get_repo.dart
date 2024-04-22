import 'package:dio/dio.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
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
  ApiService apiService;

  GetRepo({required this.apiService});

  Future<Result<Model,CustomError>> getPosts()async
  {
    Result<Response,CustomError> getPostsResponse = await apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.getPosts,
            withToken: false
        ),
    );
    return getPostsResponse.when(
          (success) => Result.success(Executer().factory(success)),
          (error) => Result.error(error),
    );
  }

  Future<Result<Model,CustomError>> getCommentsForPost(int postId)async
  {
    Result<Response, CustomError> getCommentsResponse = await apiService.callApi(
      request: RequestModel(
          method: Methods.GET,
          endPoint: ApiConstants.getComments,
          queryParams: {'post_id' : postId},
          withToken: false
      ),
    );
    return getCommentsResponse.when(
          (success) => Result.success(Executer().factory(success)),
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
        withToken: false,
      ),
    );

    return getAllCategoriesRes.when(
          (success) =>
          Result.success((getAllCategoriesRes.tryGetSuccess()!
              .data['data']['plants'] as List).map((e) =>
              Plant(
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
              )).toList()),
          (error) => Result.error(error),
    );
  }

  Future<Result<List<Plant>,CustomError>> getPopularPlants()async
  {
    Result<Response, CustomError> getPopularPlantsRes = await apiService.callApi(
      request: RequestModel(
        method: Methods.GET,
        endPoint: ApiConstants.popularPlants,
        withToken: false,
      ),
    );

    return getPopularPlantsRes.when(
          (success) =>
          Result.success((getPopularPlantsRes.tryGetSuccess()!
              .data['data'] as List).map((e) =>
              Plant(
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
              )).toList()),
          (error) => Result.error(error),
    );
  }

  Future<Result<List<Plant>,CustomError>> getSpecificPlantsByCategory(int id)async
  {
    Result<Response, CustomError> getCategoryPlansRes = await apiService
        .callApi(
      request: RequestModel(
        method: Methods.GET,
        endPoint: ApiConstants.plantsByCategory,
        queryParams: {'category_id' : id},
        withToken: false,
      ),
    );

    return getCategoryPlansRes.when(
            (success) => Result.success(
                (getCategoryPlansRes.getOrThrow().data['data'] as List).map((e) => Plant(
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
                )).toList()
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
              CacheHelper.getInstance().sharedPreferences.getStringList('userData')![0].toInt(),
            },
            withToken: false,
        ),
    );
   return profileDataResponse.when(
           (success) => Result.success(Executer().factory(success)),
           (error) => Result.error(error),
   );
  }


}
