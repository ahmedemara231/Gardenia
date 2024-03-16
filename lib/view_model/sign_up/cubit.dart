import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view_model/sign_up/states.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpCubit extends Cubit<SignUpStates>
{
  SignUpCubit() : super(SignUpInitialState());
  factory SignUpCubit.getInstance(context) => BlocProvider.of(context);

  bool isVisible = true;
  void changePasswordVisibility()
  {
    isVisible = !isVisible;
    emit(ChangePasswordVisibilityState());
  }

  RoundedLoadingButtonController signUpButtonCont = RoundedLoadingButtonController();
  Future<void> signUp(BuildContext context) async
  {
    await Future.delayed(const Duration(seconds: 2),()
    {
      signUpButtonCont.success();

      Future.delayed(const Duration(seconds: 1),() {
        context.removeOldRoute(Login());
      },);

    },);
  }
}