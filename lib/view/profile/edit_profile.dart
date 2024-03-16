import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/myText.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          text: 'Edit profile',
          color: Constants.appColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
    );
  }
}
