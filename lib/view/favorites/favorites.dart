import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view/categories/shimmers/specific_category_shimmer.dart';
import 'package:gardenia/view/plant_details/plant_details.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  @override
  void initState() {
    CategoriesCubit.getInstance(context).getFavPlants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          text: 'Favorites',
          color: Constants.appColor,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<CategoriesCubit,CategoriesStates>(
        listener: (context, state)
        {
          if(state is GetFavListSuccess)
            {
              log('the state is $state');
            }
          else if(state is AddRemFavorites)
            {
              log('the state is $state');
            }
        },
        builder: (context, state) => state is GetFavListLoading?
        const SpecificCategoriesShimmer():
        CategoriesCubit.getInstance(context).favList.isEmpty?
        Center(
            child: MyText(
              text: 'No Favorites Yet',
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
            ),
        ):
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 5.w,
              childAspectRatio: .8,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) =>
            InkWell(
              onTap: () => context.normalNewRoute(
                  PlantDetails(
                    plant: CategoriesCubit.getInstance(context).favList[index],
                  ),
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                          height: 100.h,
                          child: Image.network(
                            CategoriesCubit.getInstance(context).favList[index].image,
                            fit: BoxFit.fill,
                          )
                      ),
                      Expanded(
                        child: ListTile(
                          title: MyText(
                            text: CategoriesCubit.getInstance(context).favList[index].name,
                            color: Constants.appColor,
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: MyText(text: CategoriesCubit.getInstance(context).favList[index].type),
                          // trailing: IconButton(
                          //     onPressed: () async
                          //     {
                          //       await CategoriesCubit.getInstance(context).addRemFavorites(
                          //           context,
                          //           page: CurrentPage.fav,
                          //           plantId: CategoriesCubit.getInstance(context).favList[index].id,
                          //       );
                          //     },
                          //     icon: Image.asset(Constants.controlFavButton)
                          // ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            itemCount: CategoriesCubit.getInstance(context).favList.length,
          ),
        ),
      ),
    );
  }
}