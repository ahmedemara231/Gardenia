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
  Future<void> getAllCategories()async
  {
    emit(GetCategoriesLoadingState());
    await getRepo.getAllCategories().then((result)
    {
      if(result.isSuccess())
        {
          allCategories = result.tryGetSuccess()!;
          allCategories.sublist(0, allCategories.length ~/ 2);
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

}