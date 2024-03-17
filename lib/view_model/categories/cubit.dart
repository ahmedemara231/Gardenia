import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/view_model/categories/states.dart';

class CategoriesCubit extends Cubit<CategoriesStates>
{
  CategoriesCubit() : super(CategoriesInitState());

  factory CategoriesCubit.getInstance(context) => BlocProvider.of(context);

}