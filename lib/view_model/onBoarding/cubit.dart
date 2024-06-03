import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/view_model/onBoarding/states.dart';
import 'package:page_transition/page_transition.dart';
import '../../view/auth/first_view/first_view.dart';

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

  Future<void> moveToLogin(context)async
  {
    Navigator.pushAndRemoveUntil(
      context, PageTransition(
      child: const FirstView(),
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 700),
    ), (route) => false,
    );

    await CacheHelper.getInstance().setData(
        key: 'finishOnBoarding', value: true
    ).then((value) => debugPrint('finish onBoarding'));
  }
}