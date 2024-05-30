import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';

class PrivacyPolicyModel extends StatelessWidget {

  final String title;
  final String value;

  const PrivacyPolicyModel({super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: title,
          maxLines: 7,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 5.h),
        MyText(
            text: value,
            maxLines: 7,
            fontSize: 14.sp
        )
      ],
    );
  }
}
