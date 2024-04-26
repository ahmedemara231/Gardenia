import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/model/local/flutter_secure_storage.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view/auth/otp_code/screen.dart';
import 'package:gardenia/view/auth/sign_up/sign_up.dart';
import 'package:gardenia/view/bottomNavBar/bottom_nav_bar.dart';
import 'package:gardenia/view/categories/all/categories.dart';
import 'package:gardenia/view/categories/base_screen/base_screen.dart';
import 'package:gardenia/view/create_post/create_post.dart';
import 'package:gardenia/view/home/home.dart';
import 'package:gardenia/view/onBoarding/onBoarding_screen.dart';
import 'package:gardenia/view/plant_details/plant_details.dart';
import 'package:gardenia/view/settting/setting.dart';
import 'package:gardenia/view/profile/profile.dart';
import 'package:gardenia/view_model/Login/cubit.dart';
import 'package:gardenia/view_model/Login/states.dart';
import 'package:gardenia/view_model/bloc_observer.dart';
import 'package:gardenia/view_model/bottomNavBar/cubit.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/create_post/cubit.dart';
import 'package:gardenia/view_model/forgot_reset_pass/cubit.dart';
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
          BlocProvider(create: (context) =>  ProfileCubit()),
          BlocProvider(create: (context) =>  UpdateProfileCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
        ),
      ),
    );
  }
}
class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                LoginCubit.getInstance(context).inc();
              }, icon: Icon(Icons.add,size: 50,)),
          BlocBuilder<LoginCubit,LoginStates>(
            builder: (context, state) => MyText(text: '${LoginCubit.getInstance(context).counter}',fontSize: 50,)
          ),
        ],
      )
    );
  }
}

