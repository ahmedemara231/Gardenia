import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/model/local/flutter_secure_storage.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/modules/methods/check_internet_connection.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view/google_maps/map_view.dart';
import 'package:gardenia/view/home/home.dart';
import 'package:gardenia/view/onBoarding/onBoarding_screen.dart';
import 'package:gardenia/view_model/Login/cubit.dart';
import 'package:gardenia/view_model/Login/states.dart';
import 'package:gardenia/view_model/bloc_observer.dart';
import 'package:gardenia/view_model/bottomNavBar/cubit.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/create_post/cubit.dart';
import 'package:gardenia/view_model/forgot_reset_pass/cubit.dart';
import 'package:gardenia/view_model/google_maps/cubit.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:gardenia/view_model/onBoarding/cubit.dart';
import 'package:gardenia/view_model/profile/cubit.dart';
import 'package:gardenia/view_model/sign_up/cubit.dart';
import 'package:gardenia/view_model/update_profile/cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.getInstance().cacheInit();
  SecureStorage.getInstance().init();
  Bloc.observer = MyBlocObserver();
  runApp(const Gardenia());
}

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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:
          MapView(),
          // token == null?
          // OnBoarding() : const Home(),
        ),
      ),
    );
  }
}