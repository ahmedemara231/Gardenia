import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view/bottomNavBar/bottom_nav_bar.dart';
import 'package:gardenia/view/categories/base_screen/base_screen.dart';
import 'package:gardenia/view/create_post/create_post.dart';
import 'package:gardenia/view/home/home.dart';
import 'package:gardenia/view/onBoarding/onBoarding_screen.dart';
import 'package:gardenia/view/profile/edit_profile/edit_profile.dart';
import 'package:gardenia/view/profile/profile.dart';
import 'package:gardenia/view/settting/setting.dart';
import 'package:gardenia/view/settting/setting/notifications.dart';
import 'package:gardenia/view/settting/setting/privacy_policy.dart';
import 'package:gardenia/view_model/Login/cubit.dart';
import 'package:gardenia/view_model/bottomNavBar/cubit.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/create_post/cubit.dart';
import 'package:gardenia/view_model/forgot_reset_pass/cubit.dart';
import 'package:gardenia/view_model/google_maps/cubit.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:gardenia/view_model/onBoarding/cubit.dart';
import 'package:gardenia/view_model/profile/cubit.dart';
import 'package:gardenia/view_model/setting/cubit.dart';
import 'package:gardenia/view_model/sign_up/cubit.dart';
import 'package:gardenia/view_model/update_profile/cubit.dart';
import 'model/local/secure_storage.dart';
import 'model/local/shared_prefs.dart';
import 'modules/data_types/permission_process.dart';
import 'modules/methods/check_permission.dart';

class Gardenia extends StatefulWidget {
  const Gardenia({super.key});

  @override
  State<Gardenia> createState() => _GardeniaState();
}

class _GardeniaState extends State<Gardenia> {

  String? token;
  @override
  void initState() {
    SecureStorage.getInstance().readData(key: 'userToken').then((value) {
      token = value;
    });
    checkPermission(
      PermissionProcessModel(
        permissionClient: PermissionClient.notification,
        onPermissionGranted: () {},
        onPermissionDenied: () {},
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) =>  OnBoardingCubit()),
          BlocProvider(create: (context) =>  BottomNavCubit()),
          BlocProvider(create: (context) =>  LoginCubit()),
          BlocProvider(create: (context) =>  SignUpCubit()),
          BlocProvider(create: (context) =>  ForgotResetPassCubit()),
          BlocProvider(create: (context) =>  HomeCubit()),
          BlocProvider(create: (context) =>  CategoriesCubit()),
          BlocProvider(create: (context) =>  CreatePostCubit()),
          BlocProvider(create: (context) =>  ProfileCubit()),
          BlocProvider(create: (context) =>  UpdateProfileCubit()),
          BlocProvider(create: (context) =>  MapsCubit()),
          BlocProvider(create: (context) =>  SettingCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:
          Login()
          // Categories()
          // Setting()
          // CacheHelper.getInstance().shared.getBool('finishOnBoarding') == true?
          // token == null?
          // Login() : BottomNavBar():
          // OnBoarding(),
        ),
      ),
    );
  }
}