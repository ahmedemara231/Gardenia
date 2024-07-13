import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/model/remote/api_service/repositories/get_repo.dart';
import 'package:gardenia/model/remote/api_service/repositories/post_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/modules/base_widgets/snackBar.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/modules/data_types/plant.dart';
import 'package:gardenia/view_model/categories/states.dart';

import '../../model/remote/paypal/models/item.dart';

class CategoriesCubit extends Cubit<CategoriesStates>
{
  CategoriesCubit() : super(CategoriesInitState());

  factory CategoriesCubit.getInstance(context) => BlocProvider.of(context);

  GetRepo getRepo = GetRepo(apiService: DioConnection.getInstance());


  List<Plant> cartPlants = [Plant(id: 1, name: 'name', image: 'image', description: 'description', type: 'type', light: 'light', ideal_temperature: 'ideal_temperature', resistance_zone: 'resistance_zone', suitable_location: 'suitable_location', careful: 'careful', liquid_fertilizer: 'liquid_fertilizer', clean: 'clean', toxicity: 'toxicity', names: 'names', price: 100)];

  late List<int> numbersOfCopiesList;
  void makeNumbersOfCopies()
  {
    numbersOfCopiesList = [];
    for (var value in cartPlants) {
      numbersOfCopiesList.add(1);
    }
  }

  void addCopy(int index)
  {
    numbersOfCopiesList[index]++;
    emit(AddCopy());
  }

  void decCopy(int index)
  {
    if(numbersOfCopiesList[index] > 1)
      {
        numbersOfCopiesList[index]--;
        emit(RemoveCopy());
      }
  }

  void removeCopy(int index)
  {
    numbersOfCopiesList.removeAt(index);
  }

  void putPlantInCart(context,{required Plant plant})
  {
    if(cartPlants.contains(plant))
      {
        MyToast.showToast(context, msg: 'Already Exists',color: Colors.red);
      }
    else{
      cartPlants.add(plant);
      MyToast.showToast(context, msg: 'Added to Cart',color: Constants.appColor);
      emit(AddedTOCart());
    }
  }

  void removePlantFromCart(context,{
    required Plant plant,
    required int index
  })
  {
    cartPlants.remove(plant);
    removeCopy(index);
    emit(RemovedFromCart());
  }

  late List<Item> plantsItems;
  void transPlantToItem()
  {
    plantsItems = [];

    for (int i = 0; i < cartPlants.length; i++) {
      Item item = Item.fromPlant(plant: cartPlants[i], quantity: numbersOfCopiesList[i]);
      plantsItems.add(item);
    }
  }

  int totalAmount = 0;
  void calcTotalAmount()
  {
    totalAmount = 0;

    for(var item in plantsItems)
    {
      totalAmount = totalAmount + (item.price.toInt() * item.quantity);
    }
    emit(CalcTotalAmountSuccess());
  }

  void executeCheckoutProcess()
  {
    transPlantToItem();
    calcTotalAmount();
  }

  void finishPayment(BuildContext context)
  {
    cartPlants = List.empty(growable: true);
    numbersOfCopiesList = List.empty(growable: true);
    plantsItems = List.empty(growable: true);
    emit(FinishPayment());
  }


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


  List<Plant> favList = [];

  Future<void> getFavPlants()async
  {
    emit(GetFavListLoading());

    await getRepo.getFavPlants().then((result)
    {
      if(result.isSuccess())
        {
          favList = result.getOrThrow();

          emit(GetFavListSuccess());
        }
      else{
        emit(GetFavListError());
      }
    });
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
    emit(AddRemFavorites());
    await postRepo.addRemFavorite(plant.id);
  }

  bool isPlantExistInFav(Plant myPlant)
  {
    bool result = false;

    for(Plant plant in favList)
      {
        if(plant == myPlant)
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
    emit(AddRemFavorites());
  }
  void removePlantFromFav(Plant plant)
  {
    favList.remove(plant);
    emit(AddRemFavorites());
  }
}
enum CurrentPage {fav, plantDetails}

