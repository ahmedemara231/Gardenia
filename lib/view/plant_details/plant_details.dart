import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view/plant_details/specific_charcteristic.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';
import 'package:hexcolor/hexcolor.dart';

class PlantDetails extends StatelessWidget {
  PlantDetails({super.key});

  final List<String> characteristics = ['Careful', 'Place', 'Characteristics'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: context.setHeight(3),
          //     child: Image.asset('images/plant2.png'),
          // ),
          MyText(text: 'Aloe Vera',fontSize: 25.sp,fontWeight: FontWeight.bold,color: Constants.appColor,),
          MyText(text: 'Medicinal Aloe, Barbados Aloe, Bitter Aloe, Aloe Vera',fontWeight: FontWeight.w500,fontSize: 14.sp,color: Constants.appColor,),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
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
              ),
              SizedBox(
                width: 120.w,
                height: 170.h,
                child: GridView.count(
                  mainAxisSpacing: 7.w,
                  crossAxisSpacing: 7.w,
                  childAspectRatio: 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                    4,
                        (index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Constants.appColor,
                          ),
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
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
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
          BlocBuilder<CategoriesCubit,CategoriesStates>(
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    children: List.generate(
                      characteristics.length,
                          (index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w,
                            vertical: 14.h
                        ),
                        child: InkWell(
                          onTap: ()
                          {
                            CategoriesCubit.getInstance(context).charTab(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:
                                CategoriesCubit.getInstance(context).currentTab == index?
                                HexColor('0ACF83') :
                                null
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7.h,
                                  horizontal: 12.w
                              ),
                              child: MyText(
                                  text: characteristics[index],
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                MyText(
                  text: characteristics[CategoriesCubit.getInstance(context).currentTab],
                  fontSize: 25.sp,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
