import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';

class ScreenModel extends StatelessWidget {

  String text1;
  String text2;
  String image;

  ScreenModel({super.key,
    required this.image,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Image.asset('assets/images/plant$image.png'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Column(
              children: [
                AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(seconds: 2),
                  isRepeatingAnimation: true,
                  animatedTexts: [
                    RotateAnimatedText(
                      text1,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25.sp,
                      ),
                    ),
                  ],
                ),
                AnimatedTextKit(
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
              ],
            ),
          )
        ],
      );
  }
}
