import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/model/local/flutter_secure_storage.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/modules/methods/check_internet_connection.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view/auth/sign_up/sign_up.dart';
import 'package:gardenia/view/google_maps/google_maps.dart';
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
import 'package:flutter_test/flutter_test.dart';
void main()async {
  // test('calculates area of rectangle correctly', () {
  //   // Arrange
  //   final newScreen = 1;
  //
  //   final currentScreen = changeScreen(newScreen);
  //
  //   expect(currentScreen, equals(1));  // Expected area is 6.0
  // });

  // testWidgets(
  //   'test widget',
  //       (widgetTester)async
  //   {
  //     // await widgetTester.pumpWidget(const MyApp());
  //     final tff = find.byType(TFF);
  //     expect(tff, findsOneWidget);
  //   },
  // );
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
          MyMap(),
          // token == null?
          // OnBoarding() : const Home(),
        ),
      ),
    );
  }
}
// class Test extends StatelessWidget {
//   const Test({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           IconButton(
//               onPressed: () {
//                 LoginCubit.getInstance(context).inc();
//               }, icon: Icon(Icons.add,size: 50,)),
//           BlocBuilder<LoginCubit,LoginStates>(
//             builder: (context, state) => MyText(text: '${LoginCubit.getInstance(context).counter}',fontSize: 50,)
//           ),
//         ],
//       )
//     );
//   }
// }

