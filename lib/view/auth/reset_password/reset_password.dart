import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import '../../../constants/constants.dart';
import '../../../modules/app_widgets/app_button.dart';
import '../../../modules/base_widgets/myText.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final passCont = TextEditingController();
  final conformPassCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            children: [
              Image.asset(Constants.appLogo),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: MyText(
                  text: 'Reset Password',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              MyText(
                text: 'Please type something you’ll remember',
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                child: TFF(
                  obscureText: false,
                  controller: passCont,
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: 'New password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              TFF(
                obscureText: false,
                controller: conformPassCont,
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: 'Conform password',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                child: AppButton(onPressed: () {}, text: 'Reset Password'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
