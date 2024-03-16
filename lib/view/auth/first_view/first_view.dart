import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/modules/widgets/app_button.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view/auth/sign_up/sign_up.dart';

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
                Image.asset('images/app_logo.png'),
                Image.asset('images/app_name.png'),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            Column(
              children: [
                AppButton(
                  onPressed: ()
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                    );
                  },
                  text: 'Login',
                ),
                SizedBox(height: 12.h,),
                AppButton(
                  onPressed: ()
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
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
