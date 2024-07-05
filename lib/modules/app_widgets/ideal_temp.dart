import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/extensions/string.dart';
import '../../constants/constants.dart';
import '../base_widgets/myText.dart';

class IdealTemp extends StatefulWidget {

  final String idealTemp;


  const IdealTemp({super.key,
    required this.idealTemp,
  });


  @override
  State<IdealTemp> createState() => _IdealTempState();
}

class _IdealTempState extends State<IdealTemp> {
  double winterPosition = 0;
  double summerPosition = 0;

  List<String> divide()
  {
    List<String> idealTemps = widget.idealTemp.split("/");
    return idealTemps;
  }

  void calcWinterTempPosition()
  {

    var range = divide()[0].split("°").first;

    String firstRange = range.split("-").first;
    String lastRange = range.split("-").last;

    int average = (firstRange.toInt() + lastRange.toInt()) ~/ 2;


    if(average > 0 && average < 50)
    {
      winterPosition = context.setWidth(4);
    }
    else if(average > 50 && average < 100)
    {
      winterPosition = context.setWidth(1.7);
    }
    // else{
    //   switch(divide()[0].split("°")[0].toInt())
    //   {
    //     case 0 :
    //       winterPosition = 0;
    //     case 50:
    //       winterPosition = context.setWidth(2);
    //     case 100:
    //       winterPosition = context.setWidth(1.5);
    //   }
    // }
  }

  void calcSummerTempPosition()
  {
 
    var range = divide()[1].split("°").first;

    String firstRange = range.split("-").first;
    String lastRange = range.split("-").last;

    int average = (firstRange.toInt() + lastRange.toInt()) ~/ 2;

    if(average > 0 && average < 50)
    {
      summerPosition = context.setWidth(4);
    }
    else if(average > 50 && average < 100)
    {
      summerPosition = context.setWidth(1.7);
    }
    // else{
    //   switch(divide()[1].split("°")[0].toInt())
    //   {
    //     case 0 :
    //       summerPosition = 0;
    //     case 50:
    //       summerPosition = context.setWidth(2);
    //     case 100:
    //       summerPosition = context.setWidth(1.5);
    //   }
    // }
  }

  void calcTemp()
  {
    calcWinterTempPosition();
    calcSummerTempPosition();
  }

  @override
  void didChangeDependencies() {
    calcTemp();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(text: 'Winter',color: Colors.white,fontSize: 14.sp),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  MyText(text: '0°C',color: Colors.white,),
                  const Spacer(),
                  MyText(text: '50°C',color: Colors.white,),
                  const Spacer(),
                  MyText(text: '100°C',color: Colors.white,),
                ],
              ),
              Stack(
                children: [
                  PhysicalModel(
                    elevation: 5,
                    color: Constants.appColor.withGreen(110),
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      width: context.setWidth(1),
                      height: 18.h,
                    ),
                  ),
                  Positioned(
                    left: winterPosition,
                    child: PhysicalModel(
                      elevation: 5,
                      color: Constants.secondAppColor,
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        width: context.setWidth(3),
                        height: 18.h,
                        child: Center(
                          child: MyText(
                            text: divide()[0],
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        MyText(text: 'Summer',color: Colors.white,fontSize: 14.sp),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  MyText(text: '0°C',color: Colors.white,),
                  const Spacer(),
                  MyText(text: '50°C',color: Colors.white,),
                  const Spacer(),
                  MyText(text: '100°C',color: Colors.white,),
                ],
              ),
              Stack(
                children: [
                  PhysicalModel(
                    elevation: 5,
                    color: Constants.appColor.withGreen(110),
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      width: context.setWidth(1),
                      height: 18.h,
                    ),
                  ),
                  Positioned(
                    left: summerPosition,
                    child: PhysicalModel(
                      elevation: 5,
                      color: Constants.secondAppColor,
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        width: context.setWidth(3),
                        height: 18.h,
                        child: Center(
                          child: MyText(
                            text: divide()[1],
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


