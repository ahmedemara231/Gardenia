import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/model/remote/api_service/repositories/get_repo.dart';
import 'package:gardenia/model/remote/api_service/service/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/modules/data_types/plant.dart';
import 'package:gardenia/view_model/categories/states.dart';

class CategoriesCubit extends Cubit<CategoriesStates>
{
  CategoriesCubit() : super(CategoriesInitState());

  factory CategoriesCubit.getInstance(context) => BlocProvider.of(context);

  GetRepo getRepo = GetRepo(apiService: DioConnection.getInstance());

  late List<Plant> allCategories;
  late List<Plant> firstHalfAllCategories = [];
  late List<Plant> secondHalfAllCategories = [];

  Future<void> getAllCategories()async
  {
    emit(GetCategoriesLoadingState());
    await getRepo.getAllCategories().then((result)
    {
      if(result.isSuccess())
        {
          allCategories = result.tryGetSuccess()!;
          firstHalfAllCategories = allCategories.sublist(0, allCategories.length ~/ 2);
          secondHalfAllCategories = allCategories.sublist(allCategories.length ~/ 2, allCategories.length);
          emit(GetCategoriesSuccessState());
        }
      else{
        if(result.tryGetError() is NetworkError)
          {
            emit(GetCategoriesErrorState());
          }
      }
    },);
  }

  List<Plant> popularPlants = [];
  Future<void> getPopularPlants()async
  {
    emit(GetPopularPlantsLoadingState());
    await getRepo.getPopularPlants().then((result)
    {
      if(result.isSuccess())
      {
        popularPlants = result.tryGetSuccess()!;
        emit(GetPopularPlantsSuccessState());
      }
      else{
        if(result.tryGetError() is NetworkError)
        {
          emit(GetPopularPlantsErrorState());
        }
      }
    },);
  }

  List<String> categoriesNames = ['All', 'indoor', 'Outdoor', 'Garden', 'office'];
  Map<String, List<Plant>> categories = {};

  int currentTap = 0;
  Future<void> changeTap(int newTap)async
  {
    currentTap = newTap;
    emit(ChangeTap());

    emit(GetSpecificCategoryLoading());
    await getRepo.getSpecificPlantsByCategory(newTap).then((result)
    {
      if(result.isSuccess())
        {
          categories[categoriesNames[newTap]] = result.getOrThrow();
          emit(GetSpecificCategorySuccess());
        }
      else{
        if(result.tryGetError() is NetworkError)
          {
            emit(
                GetSpecificCategoryError(
                    message: result.tryGetError()!.message,
                ),
            );
          }
        emit(GetSpecificCategoryError());
      }
    });
  }

}