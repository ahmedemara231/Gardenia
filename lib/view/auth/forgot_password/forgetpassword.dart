import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/view/auth/otp_code/screen.dart';
import 'package:gardenia/view_model/forgot_reset_pass/cubit.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../modules/base_widgets/myText.dart';

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
            Image.asset(Constants.appLogo),
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
                controller: ForgotResetPassCubit.getInstance(context).forgotPasswordButtonCont,
                onPressed: ()async
                {
                  if(formKey.currentState!.validate())
                    {
                      await ForgotResetPassCubit.getInstance(context).forgotPassword(
                          context,
                          forgetPassCont.text
                      ).then((value) {
                        context.normalNewRoute(
                          OtpCode(
                            email: forgetPassCont.text,
                          ),
                        );
                      });
                    }
                  else{
                    ForgotResetPassCubit.getInstance(context).forgotPasswordButtonCont.reset();
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
      ),
    );
  }
}
