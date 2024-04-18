import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/base_widgets/divider.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AuthComponents extends StatelessWidget {
  const AuthComponents({super.key,
    required this.buttonName,
    required this.onPressed,
    required this.otherOptionText,
    required this.newRoute,
    required this.signUpOrIn,
    required this.btnController,
    this.navigationMethod,
  });

  final void Function()? onPressed;
  final String buttonName;
  final String otherOptionText;
  final Widget newRoute;
  final String signUpOrIn;
  final RoundedLoadingButtonController  btnController;
  final String? navigationMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          RoundedLoadingButton(
            borderRadius: 12,
            color: Constants.appColor,
            controller: btnController,
            onPressed: onPressed,
            child: SizedBox(
              height: 40.h,
              width: context.setWidth(1.1),
              child: Center(
                child: MyText(
                  text: buttonName,
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Row(
              children: [
                const Expanded(child: MyDivider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: MyText(text: 'or continue with',color: Colors.grey,fontWeight: FontWeight.w500,),
                ),
                const Expanded(child: MyDivider()),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: context.setWidth(1.2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: const Border(
                    left: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey),
                    top: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 75,
                    height: 55,
                    child: Image.asset('images/google.png'),
                  ),
                  MyText(
                    text: 'Login with Google',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                    text: otherOptionText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                ),
                TextButton(
                    onPressed: ()
                    {
                      if(navigationMethod == null)
                        {
                          context.normalNewRoute(newRoute);
                        }
                      else{
                        context.removeOldRoute(newRoute);
                      }
                    }, child: MyText(text: signUpOrIn,color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 16.sp,))
              ],
            ),
          ),
        ],
      );
  }
}
