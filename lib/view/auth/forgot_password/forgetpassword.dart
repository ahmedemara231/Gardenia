import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/modules/textFormField.dart';
import 'package:gardenia/view_model/Login/cubit.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../modules/myText.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final forgetPassCont = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          children: [
            Image.asset('images/app_logo.png'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MyText(
                text: 'Forgot Password',
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyText(
              text: 'Don’t worry! It happens. Please enter the email associated with your account.',
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0.h),
              child: Form(
                key: formKey,
                child: TFF(
                  obscureText: false,
                  controller: forgetPassCont,
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: 'Enter Your Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
            RoundedLoadingButton(
                borderRadius: 12,
                color: Constants.appColor,
                controller: LoginCubit.getInstance(context).resetPasswordButtonCont,
                onPressed: ()
                {
                  if(formKey.currentState!.validate())
                    {
                      LoginCubit.getInstance(context).sendCode(context);
                    }
                  else{
                    LoginCubit.getInstance(context).resetPasswordButtonCont.reset();
                  }
                },
                child: SizedBox(
                  width: context.setWidth(1.1),
                    child: Center(
                        child: MyText(
                          text: 'Send Code',
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                    ),
                ),
            )
          ],
        ),
      ),);
  }
}
