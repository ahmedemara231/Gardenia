import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/view/categories/shimmers/specific_category_shimmer.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';
import '../../../modules/app_widgets/specific_plant_type_model.dart';

class SpecificCategory extends StatefulWidget {
 const SpecificCategory({super.key});

  @override
  State<SpecificCategory> createState() => _SpecificCategoryState();
}

class _SpecificCategoryState extends State<SpecificCategory> {
  late CategoriesCubit categoriesCubit;

  @override
  void initState() {
    categoriesCubit = CategoriesCubit.getInstance(context);
    categoriesCubit.getSpecificCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit,CategoriesStates>(
      builder: (context, state) => state is GetSpecificCategoryLoading?
      const SpecificCategoriesShimmer() :
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child:
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .8,
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 8.w
          ),
          itemBuilder: (context, index) => InkWell(
            onTap: () {},
            child: ItemBuilder(
                image: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].image,
                name: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].name,
                type: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].type
            ),
          ),
          itemCount: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]!.length,
        ),
      ),
    );
  }
}