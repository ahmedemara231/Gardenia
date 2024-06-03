import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/base_widgets/expandable_text.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';

class Characteristics extends StatelessWidget {

  final String toxicity;
  final String names;

  const Characteristics({super.key,
    required this.toxicity,
    required this.names,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        PhysicalModel(
          elevation: 3,
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: 'Toxicity',fontSize: 14.sp,fontWeight: FontWeight.bold,color: Constants.appColor,),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Constants.secondAppColor,
                      child: const Icon(
                        Icons.dangerous_outlined,
                        color: Colors.white,
                      ),
                  ),
                  title: MyExpandableText(
                    text: toxicity,
                    size: 14.sp,
                    color: Constants.appColor,
                  )
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        PhysicalModel(
          elevation: 3,
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: 'Names',fontSize: 14.sp,fontWeight: FontWeight.bold,color: Constants.appColor,),
                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Constants.secondAppColor,
                      child: const Icon(
                        Icons.drive_file_rename_outline_sharp,
                        color: Colors.white,
                      ),
                    ),
                    title: MyExpandableText(
                      text: names,
                      size: 14.sp,
                      color: Constants.appColor,
                    )
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
