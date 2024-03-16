import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/modules/myText.dart';
import 'package:hexcolor/hexcolor.dart';

class PlantDetails extends StatelessWidget {
  const PlantDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.setHeight(3),
              child: Image.asset('images/plant2.png'),
          ),
          MyText(text: 'Aloe Vera',fontSize: 25.sp,fontWeight: FontWeight.bold,color: Constants.appColor,),
          MyText(text: 'Medicinal Aloe, Barbados Aloe, Bitter Aloe, Aloe Vera',fontWeight: FontWeight.w500,fontSize: 14.sp,color: Constants.appColor,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0.h),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Constants.appColor,
                  ),
                  width: 100.w,
                  height: 100.h,
                  child: SizedBox(
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.done,color: Colors.white),
                        SizedBox(height: 16.h,),
                        MyText(text: 'Suggestions',fontSize: 12.sp,fontWeight: FontWeight.w500,color: Colors.white,)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Constants.appColor,
                        ),
                        width: 60.w,
                        height: 45.h,
                        child: SizedBox(
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.done,color: Colors.white),
                              MyText(text: 'Simple',fontSize: 12.sp,fontWeight: FontWeight.w500,color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Constants.appColor,
                        ),
                        width: 60.w,
                        height: 45.h,
                        child: SizedBox(
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.water_drop_outlined,color: Colors.white),
                              MyText(text: 'Low',fontSize: 12.sp,fontWeight: FontWeight.w500,color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.appColor,
                      ),
                      width: 60.w,
                      height: 45.h,
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.done,color: Colors.white),
                            MyText(text: 'Simple',fontSize: 12.sp,fontWeight: FontWeight.w500,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 7.h,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.appColor,
                      ),
                      width: 60.w,
                      height: 45.h,
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.water_drop_outlined,color: Colors.white),
                            MyText(text: 'Low',fontSize: 12.sp,fontWeight: FontWeight.w500,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.appColor,
                    ),
                    width: 60.w,
                    height: 100.h,
                    child: SizedBox(
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on_sharp,color: Colors.white),
                          SizedBox(height: 16.h,),
                          MyText(text: 'Adequate',fontSize: 8.sp,fontWeight: FontWeight.w500,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: HexColor('0ACF83')
                  ),
                  child: Center(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: MyText(text: 'Add plant',color: Constants.appColor,fontSize: 14.sp,fontWeight: FontWeight.w500,),
                  )),
                ),
              ),
              SizedBox(width: 16.w,),
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border,color: HexColor('0ACF83'),))
            ],
          ),
        ],
      ),
    );
  }
}
