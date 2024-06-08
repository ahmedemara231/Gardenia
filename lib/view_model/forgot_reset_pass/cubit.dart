import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/remote/api_service/repositories/post_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/modules/data_types/reset_password.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view/auth/reset_password/reset_password.dart';
import 'package:gardenia/view_model/forgot_reset_pass/states.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotResetPassCubit extends Cubit<ForgotResetPassStates>
{
  ForgotResetPassCubit() : super(ForgotResetPassInitialState());
  factory ForgotResetPassCubit.getInstance(context) => BlocProvider.of(context);


  final sendCodeCont = TextEditingController();
  void resetCont()
  {
    sendCodeCont.text = '';
    emit(state);
  }

  void fillCont(String pin)
  {
    sendCodeCont.text = pin;
    emit(FillContState());
  }

  final RoundedLoadingButtonController forgotPasswordButtonCont = RoundedLoadingButtonController();
  PostRepo postRepo = PostRepo(apiService: DioConnection.getInstance());

  Future<void> forgotPassword(BuildContext context,String email)async{
    emit(SendCodeToEmailLoading());
    await postRepo.forgotPassword(email).then((result)
    {
      if(result.isSuccess())
        {
          forgotPasswordButtonCont.reset();
          emit(SendCodeToEmailSuccess());
        }
      else{
        MyToast.showToast(
            context, msg: result.tryGetError()!.message!,
            color: Colors.red
        );
        forgotPasswordButtonCont.reset();
        emit(SendCodeToEmailError());
      }
    });
  }

  final sendCodeBtnCont = RoundedLoadingButtonController();
  Future<void> sendCode(BuildContext context,{
    required String email,
    required String code,
  })async
  {
    emit(SendCodeToEmailLoading());
    await postRepo.sendOTPCode(email: email, code: code).then((result)
    {
      if(result.isSuccess())
        {
          context.normalNewRoute(
              ResetPassword(
                email: email,
              ),
          );
          sendCodeBtnCont.reset();
          emit(SendOtpToEmailSuccess());
        }
      else{
        MyToast.showToast(
          context,
          msg: result.tryGetError()!.message!,
          color: Colors.red,
        );
        sendCodeBtnCont.reset();
        emit(SendOtpToEmailError());
      }
    });
  }

  Future<void> resetPassword(BuildContext context,{
    required ResetPasswordModel resetPasswordModel
  })async
  {
    emit(ResetNewPasswordLoading());
    await postRepo.resetPassword(
        resetPassword: resetPasswordModel,
    ).then((result)
    {
      if(result.isSuccess())
      {
        MyToast.showToast(
          context,
          msg: result.tryGetSuccess()!.message,
          color: Constants.appColor,
        );
        context.removeOldRoute(
          Login()
        );
        emit(ResetNewPasswordSuccess());
      }
      else{
        emit(ResetNewPasswordError());
      }
    });
  }

}