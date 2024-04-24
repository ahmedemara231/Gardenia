import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/view/home/home.dart';
import 'package:gardenia/view_model/bottomNavBar/cubit.dart';
import 'package:gardenia/view_model/bottomNavBar/states.dart';
import 'package:hexcolor/hexcolor.dart';
import '../categories/base_screen/base_screen.dart';
import '../favorites/favorites.dart';
import '../profile/profile.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final List<Widget> screens =
  [
    const Home(),
    Categories(),
    const Favorites(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit,BottomNavStates>(
      builder: (context, state) => Scaffold(
        bottomNavigationBar: Container(
          height: context.setHeight(11),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
              borderRadius:  BorderRadius.vertical(
                  top: Radius.circular(16)
              )
          ),
          child: BottomNavigationBar(
            items:
            const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.category),label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: ''),
              // BottomNavigationBarItem(icon: Icon(Icons.person_2),label: '')
            ],
            backgroundColor: Constants.appColor,
            selectedIconTheme: IconThemeData(
                color: HexColor('#45A415'),
                size: 30.sp
            ),
            unselectedIconTheme: IconThemeData(
                color: Colors.white,
                size: 22.sp
            ),
            onTap: (newScreen)
            {
              BottomNavCubit.getInstance(context).changeScreen(newScreen);
            },
            currentIndex: BottomNavCubit.getInstance(context).currentIndex,
          ),
        ),
        body: screens[BottomNavCubit.getInstance(context).currentIndex],
      ),
    );
  }
}
