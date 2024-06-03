import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/context.dart';
import '../../constants/constants.dart';
import '../base_widgets/myText.dart';

class AllPlantsModel extends StatelessWidget {

  String imageUrl;
  String plantName;
  String plantType;

  AllPlantsModel({super.key,
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
          padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 5),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  width: double.infinity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
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
