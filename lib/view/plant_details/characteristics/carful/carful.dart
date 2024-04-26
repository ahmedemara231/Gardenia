import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
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
                    child: carfulData.leading1,
                  ),
                  title: MyText(
                    text: carfulData.title1,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: carfulData.subTitle1,
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
                    child: carfulData.leading2
                  ),
                  title: MyText(
                    text: carfulData.title2,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: carfulData.subTitle2,
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
                    child: carfulData.leading4
                  ),
                  title: MyText(
                    text: carfulData.title4,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: carfulData.subTitle4,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ) ,
                ),
                ListTile(
                  title: MyText(
                    text: carfulData.title5,
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle:MyText(
                    text: carfulData.subTitle5,
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
                  text: 'Clean',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                Row(
                  children: [
                    carfulData.leading5,
                    MyText(text: carfulData.title6,fontSize: 10.sp,fontWeight: FontWeight.w500,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}