import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';

class SpecificChar extends StatelessWidget {

  Widget leading1;
  Widget leading2;
  Widget leading3;
  Widget leading4;
  String title1;
  String title2;
  String title3;
  String title4;
  String subTitle1;
  String subTitle2;
  String subTitle3;
  String subTitle4;
  String containerTwoTitle;
  String containerTwoText;
  String containerThreeTitle;

  SpecificChar({super.key,
    required this.leading1,
    required this.leading2,
    required this.leading3,
    required this.leading4,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    required this.subTitle1,
    required this.subTitle2,
    required this.subTitle3,
    required this.subTitle4,
    required this.containerTwoTitle,
    required this.containerTwoText,
    required this.containerThreeTitle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Constants.appColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Constants.secondAppColor,
                    radius: 20.sp,
                    child: leading1,
                  ),
                  title: MyText(
                    text: title1,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: subTitle1,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ) ,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Constants.secondAppColor,
                    radius: 20.sp,
                    child: leading2
                  ),
                  title: MyText(
                    text: title2,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: subTitle2,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ) ,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Constants.appColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                MyText(
                  text: containerTwoTitle,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Constants.secondAppColor,
                    radius: 20.sp,
                    child: leading3
                  ),
                  title: MyText(
                    text: title3,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: subTitle3,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ) ,
                ),

                MyText(
                  text: containerTwoText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Constants.appColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                MyText(
                  text: containerThreeTitle,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Constants.secondAppColor,
                    radius: 20.sp,
                    child: leading4
                  ),
                  title: MyText(
                    text: title4,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: subTitle4,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ) ,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
