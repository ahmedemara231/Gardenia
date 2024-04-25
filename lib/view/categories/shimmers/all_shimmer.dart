import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/constants.dart';
import '../../../modules/app_widgets/all_plant_model.dart';
import '../../../modules/app_widgets/popular_plants.dart';
import '../../../modules/base_widgets/myText.dart';

class AllShimmer extends StatelessWidget {
  const AllShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      period: const Duration(seconds: 2),

      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: context.setHeight(5),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => AllPlantsModel(
                      imageUrl: '',
                      plantName: '',
                      plantType: '',
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                    itemCount: 6
                  ),
                ),
                SizedBox(height: 16.h,),
                SizedBox(
                  height: context.setHeight(5),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => AllPlantsModel(
                      imageUrl: '',
                      plantName: '',
                      plantType: '',
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                    itemCount: 6
                  ),
                ),
              ],
            ),
        
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0.h),
              child: Row(
                children: [
                  MyText(
                      text: 'Popular',
                      color: Constants.appColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: MyText(
                        text: 'See all',
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
        
            SizedBox(
              height: context.setHeight(6),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {},
                    child: PopularPlants(
                      image: '',
                      type: '',
                      plantName: '',
                    )
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
