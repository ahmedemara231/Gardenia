import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/model/local/flutter_secure_storage.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/service_locator/get_it.dart';
import 'package:gardenia/test/test.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view/auth/otp_code/screen.dart';
import 'package:gardenia/view/auth/sign_up/sign_up.dart';
import 'package:gardenia/view/bottomNavBar/bottom_nav_bar.dart';
import 'package:gardenia/view/categories/categories.dart';
import 'package:gardenia/view/create_post/create_post.dart';
import 'package:gardenia/view/home/home.dart';
import 'package:gardenia/view/onBoarding/onBoarding_screen.dart';
import 'package:gardenia/view_model/Login/cubit.dart';
import 'package:gardenia/view_model/bloc_observer.dart';
import 'package:gardenia/view_model/bottomNavBar/cubit.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/create_post/cubit.dart';
import 'package:gardenia/view_model/forgot_reset_pass/cubit.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:gardenia/view_model/onBoarding/cubit.dart';
import 'package:gardenia/view_model/sign_up/cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.getInstance().cacheInit();
  SecureStorage.getInstance().init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
        ),
      ),
    );
  }
}
