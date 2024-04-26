import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/data_types/plant.dart';
import 'package:gardenia/view/categories/shimmers/specific_category_shimmer.dart';
import 'package:gardenia/view/plant_details/plant_details.dart';
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
  late List<Plant> specificCategory;
  @override
  void initState() {
    categoriesCubit = CategoriesCubit.getInstance(context);
    categoriesCubit.getSpecificCategory();
    specificCategory = categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]!;
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
            onTap: ()
            {
              context.normalNewRoute(
                PlantDetails(
                  plant: Plant(
                      id: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].id,
                      name: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].name,
                      image: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].image,
                      description: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].description,
                      type: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].type,
                      light: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].light,
                      ideal_temperature: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].ideal_temperature,
                      resistance_zone: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].resistance_zone,
                      suitable_location: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].suitable_location,
                      careful: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].careful,
                      liquid_fertilizer: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].liquid_fertilizer,
                      clean: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].clean,
                      toxicity: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].toxicity,
                      names: categoriesCubit.categories[categoriesCubit.categoriesNames[categoriesCubit.currentTap]]![index].names
                  ),
                ),
              );
            },
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