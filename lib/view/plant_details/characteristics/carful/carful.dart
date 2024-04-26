import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/base_widgets/expandable_text.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';

import '../../../../modules/data_types/carful_data_model.dart';

class Carful extends StatelessWidget {

  CarfulData carfulData;

  Carful({super.key,
    required this.carfulData,
  });

  Decoration containerDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Constants.appColor
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: containerDecoration,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: 'Light',fontSize: 14.sp,fontWeight: FontWeight.bold,color: Colors.white,),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Constants.secondAppColor,
                    radius: 20.sp,
                    child: carfulData.lightLeading,
                  ),
                  title: MyText(
                    text: carfulData.lightTitle,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: carfulData.lightSubTitle,
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
          decoration: containerDecoration,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'Care',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Constants.secondAppColor,
                    radius: 20.sp,
                    child: carfulData.cateLeading
                  ),
                  title: MyText(
                    text: carfulData.careTitle,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: carfulData.careSubTitle,
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
          decoration: containerDecoration,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'Fertilizer',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Constants.secondAppColor,
                    radius: 20.sp,
                    child: carfulData.fertilizerLeading
                  ),
                  title: MyExpandableText(
                    text: carfulData.fertilizerTitle,
                    color: Colors.white,
                    size: 14.sp,
                  )
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: containerDecoration,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'Clean',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ListTile(
                  leading: carfulData.cleanLeading,
                  title: MyExpandableText(
                    text: carfulData.cleanTitle,
                    size: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}