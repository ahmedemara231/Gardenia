import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../modules/app_widgets/app_button.dart';
import '../../modules/base_widgets/myText.dart';

class ErrorBuilder extends StatelessWidget {

  final String message;
  final void Function()? onPressed;

  const ErrorBuilder({super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: MyText(text: message),
          ),
          AppButton(
            onPressed: onPressed,
            text: 'try again',
            width: 5,
          ),
        ],
      ),
    );
  }
}
