import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/local/secure_storage.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view/bottomNavBar/bottom_nav_bar.dart';
import 'package:gardenia/view/onBoarding/onBoarding_screen.dart';
import '../model/local/shared_prefs.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  String? waitingToken;
  Future<void> getToken() async
  {
    String? token = await SecureStorage.getInstance().readData(key: 'userToken');
    waitingToken = token;
  }
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    getToken();
    Timer(
        const Duration(seconds: 2), () {
        // context.removeOldRoute(OnBoarding());
      if(CacheHelper.getInstance().shared.getBool('finishOnBoarding') == true)
      {
        if(waitingToken == null)
          {
            context.normalNewRoute(Login());
          }
        else{
          context.normalNewRoute(BottomNavBar());
        }
      }
      else{
        context.normalNewRoute(OnBoarding());
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values
    );
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: context.setHeight(1),
              width: context.setWidth(1),
              child: Image.asset(Constants.splashImage,fit: BoxFit.fill)
          ),
          Positioned(
            top: 60.h,
            left: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: 'WELCOME',fontSize: 45.sp,color: Constants.appColor,),
                MyText(text: 'Let\'s start',fontSize: 20.sp,color: Constants.appColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
