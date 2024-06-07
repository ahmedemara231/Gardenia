import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/model/remote/api_service/repositories/get_repo.dart';
import 'package:gardenia/model/remote/api_service/repositories/post_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/modules/data_types/plant.dart';
import 'package:gardenia/view/plant_details/characteristics/carful/carful.dart';
import 'package:gardenia/view/plant_details/characteristics/characteristics/characteristics.dart';
import 'package:gardenia/view/plant_details/characteristics/place/place.dart';
import 'package:gardenia/view_model/categories/states.dart';
import '../../modules/data_types/place_data_model.dart';

class CategoriesCubit extends Cubit<CategoriesStates>
{
  CategoriesCubit() : super(CategoriesInitState());

  factory CategoriesCubit.getInstance(context) => BlocProvider.of(context);

  GetRepo getRepo = GetRepo(apiService: DioConnection.getInstance());

  List<List<Plant>> allCategory = [[],[]];

  Future<void> getAllCategories(context)async
  {
    if(allCategory[0].isNotEmpty || allCategory[1].isNotEmpty)
      {
        return;
      }
    else{
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
        emit(GetCategoriesSuccessState());
      });
    }
  }


  List<String> categoriesNames = ['All', 'indoor', 'Outdoor', 'Garden', 'office'];
  Map<String, List<Plant>> categories = {};

  void open()
  {
    for(int i = 0; i < categoriesNames.length; i++)
    {
      categories[categoriesNames[i]] = [];
    }
  }


  int currentTap = 0;

  void changeTab(int newTab)
  {
    currentTap = newTab;
    emit(ChangeTap());
  }

  Future<void> getSpecificCategory()async
  {
    if(categories[categoriesNames[currentTap]]!.isEmpty)
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

  int currentTab = 0;
  void changeCharTab(int newTab)
  {
    currentTab = newTab;
    emit(ChangeCharTab());
  }



  late List<Widget> characteristics;
  void initCharacteristics({
    required List<Map<String,dynamic>> carefulData,
    required PLaceDataModel pLaceDataModel,
    required String toxicity,
    required String names,
  })
  {
    [
      Careful(carefulData: carefulData),
      Place(pLaceDataModel: pLaceDataModel),
      Characteristics(toxicity: toxicity, names: names)
    ];
    emit(InitCharacteristics());
  }

  List<Plant> favList = [];
  bool isSpecificPlantExists = false;

  Future<void> getFavPlants()async
  {
    emit(GetFavListLoading());

    await getRepo.getFavPlants().then((result)
    {
      if(result.isSuccess())
        {
          favList = result.getOrThrow();

          initPlantsNames();

          emit(GetFavListSuccess());
        }
      else{
        emit(GetFavListError());
      }
    });
  }

  late List<String> plantsNames;
  void initPlantsNames()
  {
    plantsNames = [];

    for(Plant plant in favList)
    {
      plantsNames.add(plant.name);
    }
  }

  PostRepo postRepo = PostRepo(apiService: DioConnection.getInstance());

  Future<void> addRemFavorites(context, {
    required Plant plant,
    required int plantId,
    required CurrentPage page,
  })async
  {
    if(page == CurrentPage.fav)
      {
        await removeItemFromFavorites(plant);
      }
    else{
      bool result = isPlantExistInFav(plant);
      if(result)
        {
          removePlantFromFav(plant);
        }
      else{
        addPlantToFav(plant);
      }
      emit(AddRemFavorites());
      await postRepo.addRemFavorite(plantId);
    }

    MyToast.showToast(context, msg: 'Done');
  }

  Future<void> removeItemFromFavorites(Plant plant)async
  {
    favList.remove(plant);
    plantsNames.remove(plant.name);
    emit(AddRemFavorites());
    await postRepo.addRemFavorite(plant.id);
  }

  bool isPlantExistInFav(Plant plant)
  {
    late bool result;

    for(String plantName in plantsNames)
      {
        if(plantName == plant.name)
          {
            result = true;
            break;
          }
        else{
          result = false;
        }
      }

    return result;
  }

  void addPlantToFav(Plant plant)
  {
    favList.add(plant);
    plantsNames.add(plant.name);
    emit(AddRemFavorites());
  }
  void removePlantFromFav(Plant plant)
  {
    favList.remove(plant);
    plantsNames.remove(plant.name);
    emit(AddRemFavorites());
  }



}
enum CurrentPage {fav, plantDetails}

