import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/modules/myText.dart';

class AppButton extends StatelessWidget {

  void Function()? onPressed;
  String text;
  Color? buttonColor;
  Color? buttonTextColor;

  AppButton({super.key,
    required this.onPressed,
    required this.text,
    this.buttonColor,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor?? Constants.appColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
      ),
      child: SizedBox(
        height: 40.h,
        width: context.setWidth(1.2),
        child: Center(
          child: MyText(
            text: text,
            color: buttonTextColor?? Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
