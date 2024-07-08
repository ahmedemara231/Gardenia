import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/view/auth/forgot_password/forgetpassword.dart';
import 'package:gardenia/view/auth/sign_up/sign_up.dart';
import 'package:gardenia/view_model/Login/cubit.dart';
import 'package:gardenia/view_model/Login/states.dart';
import '../../../modules/app_widgets/auth_components.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h,horizontal: 16.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(Constants.appLogo),
                  MyText(
                    text: 'Log In',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0,),
                        child: MyText(
                          text: 'Email',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ),
                  TFF(
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                      obscureText: false,
                      controller: emailCont,
                      hintText: 'example@gmail.com',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                      ),
                  ),
                  SizedBox(height: 16.h,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,),
                      child: MyText(
                        text: 'Password',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  BlocBuilder<LoginCubit,LoginStates>(
                    builder: (context, state) => TFF(
                      obscureText: LoginCubit.getInstance(context).isVisible,
                      controller: passCont,
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        onPressed: ()
                        {
                          LoginCubit.getInstance(context).changePasswordVisibility();
                        },
                        icon: LoginCubit.getInstance(context).isVisible?
                        const Icon(Icons.visibility_off):
                        const Icon(Icons.visibility),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    buildWhen: (previous, current)
                    {
                      return current is ChangePasswordVisibilityState;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        BlocBuilder<LoginCubit,LoginStates>(
                          builder: (context, state) => Checkbox(
                            value: LoginCubit.getInstance(context).remember,
                            onChanged: (value)
                            {
                              LoginCubit.getInstance(context).changeRememberMe();
                            },
                          ),
                          buildWhen: (previous, current) => current is ChangeRememberMeState,
                        ),
                        MyText(
                            text: 'Remember Me',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: ()
                            {
                              context.normalNewRoute(ForgetPassword());
                            },
                            child: MyText(
                          text: 'Forgot Password?',
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                        )
                      ],
                    ),
                  ),
                  AuthComponents(
                      btnController: LoginCubit.getInstance(context).loginButtonCont,
                      signUpOrIn: 'Sign up',
                      buttonName: 'Login',
                      onPressed: ()
                      {
                        if(formKey.currentState!.validate())
                          {
                            LoginCubit.getInstance(context).login(context,
                              email: emailCont.text,
                              password: passCont.text,
                            );
                          }
                        else{
                          LoginCubit.getInstance(context).loginButtonCont.reset();
                          return;
                        }
                      },
                      otherOptionText: 'Don\'t have an account',
                      newRoute: const SignUp()
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
