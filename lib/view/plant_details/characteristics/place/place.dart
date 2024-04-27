import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/base_widgets/expandable_text.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/data_types/place_data_model.dart';
import 'package:gardenia/view/plant_details/characteristics/container_decoration.dart';

class Place extends StatelessWidget {

  final PLaceDataModel pLaceDataModel;
  const Place({super.key,
    required this.pLaceDataModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: containerDecoration2,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: MyText(
                      text: 'Resistance zone',
                      color: Constants.appColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Constants.secondAppColor,
                      radius: 20.sp,
                      child: const Icon(Icons.ac_unit,color: Colors.white,),
                    ),
                    title: MyExpandableText(
                      text: pLaceDataModel.resistanceZone,
                      color: Constants.appColor,
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
