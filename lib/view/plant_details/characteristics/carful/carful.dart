import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import '../container_decoration.dart';

class Careful extends StatelessWidget {

  List<Map<String,dynamic>> carefulData = [];

  Careful({super.key,
    required this.carefulData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          carefulData.length,
              (index) => Card(
                elevation: 4,
                child: Container(
                  decoration: containerDecoration1,
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
                          title: MyText(
                            text: carefulData[index]['title'],
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: MyText(
                            text: carefulData[index]['subTitle']??'',
                            color: Colors.white,
                            fontSize: 14.sp,
                          ) ,
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