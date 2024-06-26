import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view/auth/sign_up/sign_up.dart';
import 'package:page_transition/page_transition.dart';
import '../../../constants/constants.dart';
import '../../../modules/app_widgets/app_button.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(Constants.appLogo),
                Image.asset('assets/images/app_name.png'),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            Column(
              children: [
                AppButton(
                  width: 1.2,
                  onPressed: ()
                  {
                    Navigator.pushAndRemoveUntil(
                      context, PageTransition(
                      child: Login(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 700),
                    ), (route) => false,
                    );
                  },
                  text: 'Login',
                ),
                SizedBox(height: 12.h,),
                AppButton(
                  width: 1.2,
                  onPressed: ()
                  {
                    Navigator.pushAndRemoveUntil(
                      context, PageTransition(
                      child: const SignUp(),
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 700),
                    ), (route) => false,
                    );
                  },
                  text: 'Sign Up',
                  buttonColor: Colors.white,
                  buttonTextColor: Colors.black87,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
