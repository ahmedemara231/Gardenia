import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/service_locator/get_it.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view_model/Login/cubit.dart';
import 'package:gardenia/view_model/bloc_observer.dart';
import 'package:gardenia/view_model/bottomNavBar/cubit.dart';
import 'package:gardenia/view_model/onBoarding/cubit.dart';
import 'package:gardenia/view_model/sign_up/cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Services.getInstance().initDependencies();
  await CacheHelper.getInstance().cacheInit();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
        ),
      ),
    );
  }
}
