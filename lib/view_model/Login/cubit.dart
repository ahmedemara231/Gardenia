import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/view/auth/reset_password/reset_password.dart';
import 'package:gardenia/view/bottomNavBar/bottom_nav_bar.dart';
import 'package:gardenia/view_model/Login/states.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  factory LoginCubit.getInstance(context) => BlocProvider.of(context);


  bool isVisible = true;
  void changePasswordVisibility()
  {
    isVisible = !isVisible;
    emit(ChangePasswordVisibilityState());
  }


  final RoundedLoadingButtonController loginButtonCont = RoundedLoadingButtonController();
  Future<void> login(BuildContext context) async
  {
    await Future.delayed(const Duration(seconds: 2),()
    {
      loginButtonCont.success();

      Future.delayed(const Duration(seconds: 1),()
      {
        context.removeOldRoute(BottomNavBar());
        log('Login Success');
      },);
    },);
  }

  bool rememberMe = false;

  Future<void> changeRememberMe()async
  {
    rememberMe = !rememberMe;
    await CacheHelper.getInstance().saveLoginState(rememberMe);
    emit(ChangeRememberMeState());
  }

  final RoundedLoadingButtonController resetPasswordButtonCont = RoundedLoadingButtonController();

  Future<void> sendCode(BuildContext context)async
  {
    await Future.delayed(const Duration(seconds: 2),()
    {
      resetPasswordButtonCont.success();
      Future.delayed(const Duration(seconds: 1),()async
      {
        context.removeOldRoute(ResetPassword());
      },);
    },);
  }


}


