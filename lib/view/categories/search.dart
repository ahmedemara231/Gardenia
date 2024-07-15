import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/app_widgets/specific_plant_type_model.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view/plant_details/plant_details.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';

class Search extends SearchDelegate
{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return ArrowBackButton(
      onPressed: () => close(context, null)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isNotEmpty)
      {
        CategoriesCubit.getInstance(context).search(query);
        return BlocBuilder<CategoriesCubit,CategoriesStates>(
            builder: (context, state) =>
            state is SearchLoading?
            const Center(child: CircularProgressIndicator()):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(text: 'Result: ',fontSize: 20.sp,fontWeight: FontWeight.w500,),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 5.w
                      ),
                      itemCount: CategoriesCubit.getInstance(context).searchedPlants.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => context.normalNewRoute(
                            PlantDetails(
                                plant: CategoriesCubit.getInstance(context).searchedPlants[index]
                            )
                        ),
                        child: SpecificPlantTypeModel(
                          image: CategoriesCubit.getInstance(context).searchedPlants[index].image,
                          name: CategoriesCubit.getInstance(context).searchedPlants[index].name,
                          type: CategoriesCubit.getInstance(context).searchedPlants[index].type
                        ),
                      ),),
                  ),
                ],
              ),
            )
        );
      }
    else{
      return const SizedBox();
    }
  }

}