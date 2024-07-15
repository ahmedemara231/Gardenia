abstract class CategoriesStates {}

class CategoriesInitState extends CategoriesStates {}

class CalcTotalAmountSuccess extends CategoriesStates {}

class AddedTOCart extends CategoriesStates {}

class RemovedFromCart extends CategoriesStates {}

class AddCopy extends CategoriesStates {}

class RemoveCopy extends CategoriesStates {}

class FinishPayment extends CategoriesStates {}

class SearchLoading extends CategoriesStates {}

class SearchSuccess extends CategoriesStates {}

class SearchError extends CategoriesStates {}

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

class InitCharacteristics extends CategoriesStates{}

class GetFavListLoading extends CategoriesStates{}

class GetFavListSuccess extends CategoriesStates{}

class GetFavListError extends CategoriesStates{}



class AddRemFavorites extends CategoriesStates{}