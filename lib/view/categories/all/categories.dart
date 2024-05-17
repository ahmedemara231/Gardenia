import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/app_widgets/popular_plants.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/app_widgets/all_plant_model.dart';
import 'package:gardenia/view/categories/shimmers/all_shimmer.dart';
import 'package:gardenia/view/error_builder/error_builder.dart';
import 'package:gardenia/view/plant_details/plant_details.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {

  late CategoriesCubit categoriesCubit;
  @override
  void initState() {
    categoriesCubit = CategoriesCubit.getInstance(context);
    categoriesCubit.getAllCategories(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit,CategoriesStates>(
      builder: (context, state) {
        if(state is GetCategoriesLoadingState)
        {
          return const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: AllShimmer()
          );
        }
        else{
          if(state is GetCategoryNetworkError)
          {
            return ErrorBuilder(
              message: state.message,
              onPressed: () => CategoriesCubit.getInstance(context).getAllCategories(context),
            );
          }
          else{
            return Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: context.setHeight(5),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => context.normalNewRoute(
                              PlantDetails(
                                  plant: categoriesCubit.allCategory[0].sublist(0,categoriesCubit.allCategory[0].length ~/ 2)[index],
                              ),
                          ),
                          child: AllPlantsModel(
                            imageUrl: categoriesCubit.allCategory[0].sublist(0,categoriesCubit.allCategory[0].length ~/ 2)[index].image,
                            plantName: categoriesCubit.allCategory[0].sublist(0,categoriesCubit.allCategory[0].length ~/ 2)[index].name,
                            plantType: categoriesCubit.allCategory[0].sublist(0,categoriesCubit.allCategory[0].length ~/ 2)[index].type,
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                        itemCount: categoriesCubit.allCategory[0].sublist(0,categoriesCubit.allCategory[0].length ~/ 2).length,
                      ),
                    ),
                    SizedBox(height: 16.h,),
                    SizedBox(
                      height: context.setHeight(5),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => context.normalNewRoute(
                            PlantDetails(
                              plant: categoriesCubit.allCategory[0].sublist(categoriesCubit.allCategory[0].length ~/ 2,categoriesCubit.allCategory[0].length)[index],
                            ),
                          ),
                          child: AllPlantsModel(
                            imageUrl: categoriesCubit.allCategory[0].sublist(categoriesCubit.allCategory[0].length ~/ 2,categoriesCubit.allCategory[0].length)[index].image,
                            plantName: categoriesCubit.allCategory[0].sublist(categoriesCubit.allCategory[0].length ~/ 2,categoriesCubit.allCategory[0].length)[index].name,
                            plantType: categoriesCubit.allCategory[0].sublist(categoriesCubit.allCategory[0].length ~/ 2,categoriesCubit.allCategory[0].length)[index].type,
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                        itemCount: categoriesCubit.allCategory[0].sublist(categoriesCubit.allCategory[0].length ~/ 2,categoriesCubit.allCategory[0].length).length,
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
                        child: InkWell(
                          onTap: () => context.normalNewRoute(
                            PlantDetails(
                              plant: categoriesCubit.allCategory[1][index],
                            ),
                          ),
                          child: PopularPlants(
                            image: categoriesCubit.allCategory[1][index].image,
                            type: categoriesCubit.allCategory[1][index].type,
                            plantName: categoriesCubit.allCategory[1][index].name,
                          ),
                        )
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                    itemCount: categoriesCubit.allCategory[1].length,
                  ),
                ),
              ],
            );
          }
        }
      }
    );

  }
}
