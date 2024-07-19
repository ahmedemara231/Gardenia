import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/forgot_reset_pass/cubit.dart';
import 'package:gardenia/view_model/forgot_reset_pass/states.dart';
import 'package:pinput/pinput.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../modules/app_widgets/arrow_back_button.dart';

class OtpCode extends StatelessWidget {
  String email;
  OtpCode({super.key,
    required this.email
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(text: 'OTP Verification',fontSize: 30.sp,fontWeight: FontWeight.w500,),
            MyText(text: 'Enter the verification code we just sent to your email',color: Colors.grey,fontSize: 14.sp,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0.h),
              child: Pinput(
                controller: ForgotResetPassCubit.getInstance(context).sendCodeCont,
                length: 6,
                defaultPinTheme: PinTheme(
                  textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                  ),
                  height: 45.h,
                  width: 45.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Constants.appColor,width: 2),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                  ),
                ),
                onCompleted: (pin) => ForgotResetPassCubit.getInstance(context).fillCont(pin),
                // onTap: () {},
                // onChanged: (value) {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(text: 'Didn’t receive code?',color: Colors.grey,fontSize: 14.sp,),
                TextButton(
                    onPressed: () async
                    {
                      ForgotResetPassCubit.getInstance(context).resetCont();
                      await ForgotResetPassCubit.getInstance(context).forgotPassword(context, email);
                    },
                    child: MyText(text: 'resend',color: Constants.appColor,fontWeight: FontWeight.bold,fontSize: 14.sp,),
                )
              ],
            ),
            const Spacer(),
            BlocBuilder<ForgotResetPassCubit,ForgotResetPassStates>(
              builder: (context, state) => Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0.h),
                child: RoundedLoadingButton(
                  color: Constants.appColor,
                  borderRadius: 12,
                  controller: ForgotResetPassCubit.getInstance(context).sendCodeBtnCont,
                  onPressed: ForgotResetPassCubit.getInstance(context).sendCodeCont.text.isNotEmpty? ()async
                  {
                    await ForgotResetPassCubit.getInstance(context).sendCode(
                        context,
                        email: email,
                        code: ForgotResetPassCubit.getInstance(context).sendCodeCont.text
                    );
                  } : null,
                  child: SizedBox(
                    width: context.setWidth(1.2),
                    child: Center(child: MyText(text: 'Verify',color: Colors.white,fontSize: 16.sp,)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
