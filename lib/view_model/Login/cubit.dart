import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/local/secure_storage.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/model/model.dart';
import 'package:gardenia/model/remote/api_service/model/success_model.dart';
import 'package:gardenia/model/remote/api_service/repositories/post_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/view_model/Login/states.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../view/auth/login/login.dart';
import '../../view/bottomNavBar/bottom_nav_bar.dart';
import 'package:gardenia/model/remote/stripe/api_service/service/stripe_connection.dart';
import 'package:gardenia/model/remote/stripe/repositories/post_repo.dart';

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

  bool remember = false;
  Future<void> changeRememberMe()async
  {
    remember = !remember;
    await CacheHelper.getInstance().setData(
        key: 'rememberMe',
        value: remember
    );
    emit(ChangeRememberMeState());
  }

  PostRepo postRepo = PostRepo(apiService: DioConnection.getInstance());

  final RoundedLoadingButtonController loginButtonCont = RoundedLoadingButtonController();

  late Model loginResult;

  Future<void> login(BuildContext context, {
    required String email,
    required String password,
  }) async
  {
    emit(LoginLoadingState());

    await postRepo.login(email: email, password: password).then(
          (result) async
    {
      if(result.isSuccess())
        {
          loginButtonCont.success();
          await Future.delayed(
            const Duration(milliseconds: 1500),
                () {
              loginButtonCont.reset();
              MyToast.showToast(
                context,
                msg: 'Welcome!',
                color: Constants.appColor,
              );
              context.removeOldRoute(BottomNavBar());
            },
          );
          emit(LoginSuccessState());
        }
      else{
        loginButtonCont.error();

        if(result.tryGetError() is NetworkError || result.tryGetError() is UnprocessableEntityError)
          {
            await Future.delayed(
              const Duration(milliseconds: 1500),
                  () {
                loginButtonCont.reset();
                MyToast.showToast(
                  context,
                  msg: '${result.tryGetError()?.message}',
                  color: Colors.red,
                );
              },
            );
          }
        else{
          log(result.tryGetError()!.message!);
        }
        emit(LoginErrorState());

      } loginResult = result.getOrThrow();
      },
    );
  }

  Future<void> logout(BuildContext context)async
  {
    emit(LogoutLoadingState());

    await postRepo.refreshOrLogout(operation: Operation.logout).then((result) {
      if (result.isSuccess()) {
        context.removeOldRoute(Login());
        emit(LogoutSuccessState());
      }
      else {
        MyToast.showToast(context, msg: 'try again later', color: Colors.red);
        emit(LogoutErrorState());
      }
    });
  }


  Future<void> cacheUserData(Model loginResult)async
  {
    String userId = '${loginResult.data!['id']}';
    await CacheHelper.getInstance().setData(
        key: 'userData',
        value:
        <String>[
          userId,
          loginResult.data!['username'],
          loginResult.data!['email'],
          loginResult.data!['image']?? Constants.defaultProfileImage
        ]
    );
    await SecureStorage.getInstance().setData(
        key: 'userToken',
        value: loginResult.data!['token']
    );
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

  Future<void> makeLoginProcess(context,{
    required String email,
    required String password
  })async{
    await login(
        context,
        email: email,
        password: password
    );
    if(loginResult is SuccessModel)
      {
        await cacheUserData(loginResult);
        await createStripeCustomer(name: email.split("@").first);
      }
  }
}


// logout