import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/view_model/onBoarding/states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates>
{
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit getInstance(context) => BlocProvider.of(context);

  int pageIndex = 0;

  void moveToNextPage(int newPageIndex)
  {
    pageIndex = newPageIndex;
    emit(ChangeScreenState());
  }
}