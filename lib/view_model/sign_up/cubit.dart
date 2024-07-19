import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/remote/api_service/model/success_model.dart';
import 'package:gardenia/model/remote/api_service/repositories/post_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/modules/data_types/user_data.dart';
import 'package:gardenia/view_model/sign_up/states.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../constants/constants.dart';
import '../../model/local/secure_storage.dart';
import '../../model/remote/api_service/model/model.dart';
import '../../model/remote/api_service/service/error_handling/errors.dart';
import '../../modules/base_widgets/toast.dart';
import '../../view/auth/login/login.dart';
import 'package:gardenia/model/remote/stripe/api_service/service/stripe_connection.dart';
import 'package:gardenia/model/remote/stripe/repositories/post_repo.dart';

class SignUpCubit extends Cubit<SignUpStates>
{
  SignUpCubit() : super(SignUpInitialState());
  factory SignUpCubit.getInstance(context) => BlocProvider.of(context);

  List<bool> obscurePass = [true, true];
  void changePasswordVisibility(int index)
  {
    obscurePass[index] = !obscurePass[index];
    emit(ChangePasswordVisibilityState());
  }

  RoundedLoadingButtonController signUpButtonCont = RoundedLoadingButtonController();
  PostRepo postRepo = PostRepo(apiService: DioConnection.getInstance());

  late Model signUpResult;

  Future<Model> signUp(BuildContext context,{required UserData user}) async
  {
    emit(SignUpLoadingState());
    await postRepo.signUp(user).then((result)async
    {
      signUpResult = result.getOrThrow();

      if(result.isSuccess())
        {
          signUpButtonCont.success();
          Future.delayed(
            const Duration(milliseconds: 1500),
            () {
              signUpButtonCont.reset();
              MyToast.showToast(
                context,
                msg: 'Congratulations!',
                color: Constants.appColor,
              );
              context.removeOldRoute(Login());
            },
          );

          emit(SignUpSuccessState());
        }
      else{
        signUpButtonCont.error();

        if(result.tryGetError() is NetworkError || result.tryGetError() is UnprocessableEntityError)
          {
            Future.delayed(
              const Duration(milliseconds: 1500),
                  () {
                signUpButtonCont.reset();
                MyToast.showToast(
                  context,
                  msg: '${result.tryGetError()}',
                  color: Colors.red,
                );
              },
            );
          }
        else{
          log(result.tryGetError()!.message!);
        }
        emit(SignUpErrorState());
      }
    });
    return signUpResult;
  }

  StripePostRepo stripeRepo = StripePostRepo(apiService: StripeConnection());

  Future<void> createStripeCustomer({
    required String name,
  })async
  {
    await stripeRepo.createCustomer(name: name).then((result)
    {
      result.when(
            (success) => SecureStorage.getInstance().setData(
            key: 'customerId', value: result.getOrThrow()
        ),
            (error) => null,
      );
    });
  }

  void makeSignUpProcess(BuildContext context,{required UserData user})async
  {
    Model resultModel = await signUp(context,user: user);
    if(resultModel is SuccessModel)
    {
      await createStripeCustomer(name: user.name);
    }
  }
}