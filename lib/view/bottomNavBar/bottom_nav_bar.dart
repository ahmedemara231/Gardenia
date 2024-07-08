import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/view/home/home.dart';
import 'package:gardenia/view_model/bottomNavBar/cubit.dart';
import 'package:gardenia/view_model/bottomNavBar/states.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../modules/data_types/bottomNavigationBarItem_elements.dart';
import '../categories/base_screen/base_screen.dart';
import '../favorites/favorites.dart';
import '../profile/profile.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final List<Widget> screens =
  const [
    Home(),
    Categories(),
    Favorites(),
    Profile(),
  ];

  final List<BottomNavigationBarItemElement> elements =
  [
    BottomNavigationBarItemElement(icon: SvgPicture.asset(Constants.homeIcon,height: 22.h),label: ''),
    BottomNavigationBarItemElement(icon: SvgPicture.asset(Constants.categoriesIcon,height: 22.h),label: ''),
    BottomNavigationBarItemElement(icon: Icon(Icons.favorite,size: 28.sp,),label: ''),
    BottomNavigationBarItemElement(icon: SvgPicture.asset(Constants.personIcon,height: 22.h),label: ''),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit,BottomNavStates>(
      builder: (context, state) => Scaffold(
        bottomNavigationBar: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
              borderRadius:  BorderRadius.vertical(
                  top: Radius.circular(16)
              )
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: List.generate(
              elements.length,
                  (index) => BottomNavigationBarItem(
                    icon: elements[index].icon,
                    label: elements[index].label,
                  ),
            ),
            backgroundColor: Constants.appColor,
            selectedIconTheme: IconThemeData(
                color: HexColor('#45A415'),
                size: 30.sp
            ),
            unselectedIconTheme: const IconThemeData(
                color: Colors.white,
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

