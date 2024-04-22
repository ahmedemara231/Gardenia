import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/constants.dart';
import '../base_widgets/myText.dart';

class PopularPlants extends StatelessWidget {

  String plantName;
  String type;
  String image;

  PopularPlants({super.key,
    required this.plantName,
    required this.image,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260.w,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0.h,horizontal: 2.w),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Container(
                  width: 130.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) => MyText(text: 'Failed to load image'),
                    ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: MyText(
                      text: plantName,
                      color: Constants.appColor,
                      fontWeight: FontWeight.bold,fontSize: 12.sp,
                    ),
                  ),
                  MyText(
                      text: type,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
