import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/base_widgets/expandable_text.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';

class Careful extends StatelessWidget {

  List<Map<String,dynamic>> carefulData = [];

  Careful({super.key,
    required this.carefulData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
          carefulData.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: PhysicalModel(
                  color: Constants.appColor,
                  elevation: 7,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: MyText(
                            text: carefulData[index]['carefulSubTitle'],
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Constants.secondAppColor,
                            radius: 20.sp,
                            child: carefulData[index]['icon'],
                          ),
                          title: MyExpandableText(
                            text: carefulData[index]['title'],
                            color: Colors.white,
                            size: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),

                          subtitle: MyExpandableText(
                            text: carefulData[index]['subTitle']??'',
                            color: Colors.white,
                            size: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
      ),
    );
  }
}