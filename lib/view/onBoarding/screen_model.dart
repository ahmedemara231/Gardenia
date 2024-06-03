import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';

class ScreenModel extends StatelessWidget {

  String text1;
  String text2;
  IconData icon;
  String image;

  ScreenModel({super.key,
    required this.image,
    required this.icon,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: Image.asset('assets/images/plant$image.png'),
              ),
              Positioned(
                right: 20,
                bottom: 30,
                child: Container(
                  decoration: BoxDecoration(
                      color: Constants.appColor,
                      borderRadius: BorderRadius.circular(8.sp)
                  ),
                  width: 40.w,
                  height: 75.h,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      icon,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedTextKit(
            repeatForever: true,
            pause: const Duration(seconds: 2),
            isRepeatingAnimation: true,
            animatedTexts: [
              RotateAnimatedText(
                  text1,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30.sp,
                  ),
              ),
            ],
          ),
          SizedBox(
            width: context.setWidth(1.5),
            child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              pause: const Duration(seconds: 2),
              animatedTexts: [
                RotateAnimatedText(
                  text2,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
