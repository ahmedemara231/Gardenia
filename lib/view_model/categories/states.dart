abstract class CategoriesStates {}

class CategoriesInitState extends CategoriesStates {}

class ChangeTap extends CategoriesStates {}

class GetCategoriesLoadingState extends CategoriesStates {}

class GetCategoriesSuccessState extends CategoriesStates {}

class GetCategoriesErrorState extends CategoriesStates {}

class GetPopularPlantsLoadingState extends CategoriesStates {}

class GetPopularPlantsSuccessState extends CategoriesStates {}

class GetPopularPlantsErrorState extends CategoriesStates {}

class GetSpecificCategoryLoading extends CategoriesStates{}

class GetSpecificCategorySuccess extends CategoriesStates{}

class GetSpecificCategoryError extends CategoriesStates{
  String? message;
  GetSpecificCategoryError({this.message});
}

