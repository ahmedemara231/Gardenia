abstract class CategoriesStates {}

class CategoriesInitState extends CategoriesStates {}

class ChangeTap extends CategoriesStates {}

class ChangeCharTab extends CategoriesStates{}

class GetCategoriesLoadingState extends CategoriesStates {}

class GetCategoriesSuccessState extends CategoriesStates {}

class GetCategoriesErrorState extends CategoriesStates {}

class GetPopularPlantsLoadingState extends CategoriesStates {}

class GetPopularPlantsSuccessState extends CategoriesStates {}

class GetPopularPlantsErrorState extends CategoriesStates {}

class GetSpecificCategoryLoading extends CategoriesStates{}

class GetSpecificCategorySuccess extends CategoriesStates{}

class GetCategoryNetworkError extends CategoriesStates{
  String message;
  GetCategoryNetworkError({required this.message});
}

class GetCategoryFailure extends GetCategoryNetworkError{
  GetCategoryFailure({required super.message});
}

class AddPlantToFavState extends CategoriesStates{}

class RemovePlantFromFavState extends CategoriesStates{}