import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../modules/app_widgets/specific_plant_type_model.dart';

class SpecificCategoriesShimmer extends StatelessWidget {
  const SpecificCategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.white,
        period: const Duration(seconds: 2),

        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .8,
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 8.w
          ),
          itemBuilder: (context, index) => ItemBuilder(
              image: '',
              name: 'Name',
              type: 'Type'
          ),
          itemCount: 6,
        ),
      ),
    );
  }
}
