import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/modules/app_widgets/popular_plants.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/modules/app_widgets/plant_model.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final searchCont = TextEditingController();

  late CategoriesCubit categoriesCubit;
  @override
  void initState() {
    categoriesCubit = CategoriesCubit.getInstance(context);
    categoriesCubit.getAllCategories();
    categoriesCubit.getPopularPlants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: categoriesCubit.currentTap,
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            title: MyText(
              text: 'Categories',
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Constants.appColor,
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: const CircleAvatar(
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSKu_Had8DMwqdwykhzm6vCDJIUHYfEtnoJw&usqp=CAU'),
                ),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 10.w
                  ),
                  child: Container(
                    height: 45.h,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        color: Constants.appColor,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: TFF(
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                      obscureText: false,
                      controller: searchCont,
                      hintText: 'Search',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.white70,
                      ),
                      prefixIcon: const Icon(Icons.search,color: Colors.grey,),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70.h,
                  child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black87,
                    onTap: (newTap) => categoriesCubit.changeTap(newTap),
                    tabs:  [
                      Tab(
                        child: MyText(text: 'All',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                      ),
                      Tab(
                        child: MyText(text: 'Indoor',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                      ),
                      Tab(
                        child: MyText(text: 'Outdoor',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                      ),
                      Tab(
                        child: MyText(text: 'Garden',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                      ),
                      Tab(
                        child: MyText(text: 'office',color: Constants.appColor,fontSize: 12.sp,fontWeight: FontWeight.bold,),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<CategoriesCubit,CategoriesStates>(
                  builder: (context, state) =>
                  state is GetCategoriesLoadingState ||
                  state is GetCategoriesLoadingState?
                  const Align(
                    alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: CircularProgressIndicator(),
                      ),
                  ) :
                  SizedBox(
                    height: context.setHeight(1.4),
                    child: TabBarView(
                      // controller: tapsCont,
                      children:
                      [
                        Column(
                          children: [
                            SizedBox(
                              height: context.setHeight(5),
                              child: ListView.separated(                              scrollDirection: Axis.horizontal,
                    
                                itemBuilder: (context, index) => PlantModel(
                                  imageUrl: categoriesCubit.firstHalfAllCategories[index].image,
                                  plantName: categoriesCubit.firstHalfAllCategories[index].name,
                                  plantType: categoriesCubit.firstHalfAllCategories[index].type,
                                ),
                                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                                itemCount: categoriesCubit.firstHalfAllCategories.length,
                              ),
                            ),
                            SizedBox(height: 16.h,),
                            SizedBox(
                              height: context.setHeight(5),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => PlantModel(
                                  imageUrl: categoriesCubit.secondHalfAllCategories[index].image,
                                  plantName: categoriesCubit.secondHalfAllCategories[index].name,
                                  plantType: categoriesCubit.secondHalfAllCategories[index].type,
                                ),
                                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                                itemCount: categoriesCubit.secondHalfAllCategories.length,
                              ),
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
                                    image: categoriesCubit.popularPlants[index].image,
                                    type: categoriesCubit.popularPlants[index].type,
                                    plantName: categoriesCubit.popularPlants[index].name,
                                  )
                                ),
                                separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                                itemCount: categoriesCubit.popularPlants.length,
                              ),
                            ),
                          ],
                        ),
                        MyText(text: 'mohamed'),
                        MyText(text: 'ahmed'),
                        MyText(text: 'y'),
                        MyText(text: 'emara'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
