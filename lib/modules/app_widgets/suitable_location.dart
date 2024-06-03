import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';

class SuitableLocation extends StatelessWidget {

  final String location;
  SuitableLocation({super.key,
    required this.location,
  });

  List<String> locations = ['Indoor', 'Outdoor'];
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 3,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(text: 'Suitable location',fontWeight: FontWeight.bold,fontSize: 14.sp,color: Constants.appColor,),

            Column(
                children: List.generate(
                  locations.length,
                      (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: MyText(
                              text: locations[index],
                              fontSize: 14.sp,
                              color: Constants.appColor,
                            ),
                          ),
                            Row(
                              children: [
                                MyText(text: 'Jan',color: Constants.appColor,fontWeight: FontWeight.w500,),
                                const Spacer(),
                                MyText(text: 'Jun',color: Constants.appColor,fontWeight: FontWeight.w500,),
                                const Spacer(),
                                MyText(text: 'Dec',color: Constants.appColor,fontWeight: FontWeight.w500,),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                PhysicalModel(
                                  elevation: 5,
                                  color: Constants.secondAppColor,
                                  borderRadius: BorderRadius.circular(30),
                                  child: SizedBox(
                                    width: context.setWidth(1),
                                    height: 18.h,
                                  ),
                                ),
                                MyText(
                                  text: location,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                        ],
                      )
              )
              // [
              //
              //   MyText(text: 'Indoor',fontSize: 14.sp,color: Constants.appColor,),
              //   Row(
              //     children: [
              //       MyText(text: 'Jan',color: Constants.appColor,fontWeight: FontWeight.w500,),
              //       const Spacer(),
              //       MyText(text: 'Jun',color: Constants.appColor,fontWeight: FontWeight.w500,),
              //       const Spacer(),
              //       MyText(text: 'Dec',color: Constants.appColor,fontWeight: FontWeight.w500,),
              //     ],
              //   ),
              //   Stack(
              //     children: [
              //       PhysicalModel(
              //         elevation: 5,
              //         color: Constants.secondAppColor,
              //         borderRadius: BorderRadius.circular(30),
              //         child: SizedBox(
              //           width: context.setWidth(1),
              //           height: 18.h,
              //         ),
              //       ),
              //       MyText(text: location,fontSize: 10.sp,fontWeight: FontWeight.bold,color: Colors.white,)
              //     ],
              //   ),
              //
              //   SizedBox(height: 14.h),
              //
              //   MyText(text: 'Indoor',fontSize: 14.sp,color: Constants.appColor,),
              //   Row(
              //     children: [
              //       MyText(text: 'Jan',color: Constants.appColor,fontWeight: FontWeight.w500,),
              //       const Spacer(),
              //       MyText(text: 'Jun',color: Constants.appColor,fontWeight: FontWeight.w500,),
              //       const Spacer(),
              //       MyText(text: 'Dec',color: Constants.appColor,fontWeight: FontWeight.w500,),
              //     ],
              //   ),
              //   Stack(
              //     children: [
              //       PhysicalModel(
              //         elevation: 5,
              //         color: Constants.secondAppColor,
              //         borderRadius: BorderRadius.circular(30),
              //         child: SizedBox(
              //           width: context.setWidth(1),
              //           height: 18.h,
              //         ),
              //       ),
              //       MyText(text: location,fontSize: 10.sp,fontWeight: FontWeight.bold,color: Colors.white,)
              //     ],
              //   ),
              // ],
            ),
          ],
        ),
      ),
    );
  }
}
