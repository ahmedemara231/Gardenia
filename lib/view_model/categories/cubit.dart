import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/model/remote/api_service/repositories/get_repo.dart';
import 'package:gardenia/model/remote/api_service/service/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/modules/data_types/plant.dart';
import 'package:gardenia/view_model/categories/states.dart';

class CategoriesCubit extends Cubit<CategoriesStates>
{
  CategoriesCubit() : super(CategoriesInitState());

  factory CategoriesCubit.getInstance(context) => BlocProvider.of(context);

  GetRepo getRepo = GetRepo(apiService: DioConnection.getInstance());


  List<Plant> firstHalfAllCategories = [];
  List<Plant> secondHalfAllCategories = [];

  List<List<Plant>> allCategory = [[],[]];
  Future<void> getAllCategories(context)async
  {
    emit(GetCategoriesLoadingState());
    await Future.wait(
        [
          getRepo.getAllCategories(),
          getRepo.getPopularPlants(),
        ],
    ).then((results)async
    {
      for(int i = 0; i <= results.length - 1; i++)
      {
        if(results[i].isSuccess())
        {
          allCategory[i] = results[i].getOrThrow();
          emit(GetCategoriesSuccessState());
        }
        else{
          if(results[i].tryGetError() is NetworkError)
          {
            emit(
                GetCategoryNetworkError(
                  message: results[i].tryGetError()!.message!,
                )
            );
          }
          else{
            MyToast.showToast(
                context,
                msg: results[i].tryGetError()!.message!
            );
            emit(GetCategoriesErrorState());
          }
        }
      }
    });
  }


  List<String> categoriesNames = ['All', 'indoor', 'Outdoor', 'Garden', 'office'];
  Map<String, List<Plant>> categories = {};

  int currentTap = 0;

  void changeTab(int newTap)
  {
    currentTap = newTap;
    emit(ChangeTap());
  }

  Future<void> getSpecificCategory()async
  {
    if(categories[categoriesNames[currentTap]] == null || categories[categoriesNames[currentTap]]!.isEmpty)
      {
        emit(GetSpecificCategoryLoading());
        await getRepo.getSpecificPlantsByCategory(currentTap).then((result)
        {
          if(result.isSuccess())
          {
            categories[categoriesNames[currentTap]] = [];
            categories[categoriesNames[currentTap]] = result.getOrThrow();

            emit(GetSpecificCategorySuccess());
          }
          else{
            if(result.tryGetError() is NetworkError)
            {
              emit(
                GetCategoryNetworkError(
                  message: result.tryGetError()!.message!,
                ),
              );
            }
            else{
              emit(GetCategoriesErrorState());
            }
          }
        });
      }
    else{
      return;
    }
  }
}