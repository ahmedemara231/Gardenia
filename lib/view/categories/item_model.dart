import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import '../../constants/constants.dart';
import '../../modules/base_widgets/myText.dart';

class ItemModel extends StatelessWidget {

  String imageUrl;
  String plantName;
  String plantType;

  ItemModel({super.key,
    required this.imageUrl,
    required this.plantName,
    required this.plantType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.setWidth(2.7),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0.h,horizontal: 16.w),
          child: Column(
            children: [
              Expanded(child: Image.asset(imageUrl)),
              MyText(
                text: plantName,
                color: Constants.appColor,
                fontWeight: FontWeight.bold,fontSize: 13.sp,
              ),
              MyText(
                  text: plantType,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
              ),
            ],
          ),
        ),
      ),
    );
  }
}
