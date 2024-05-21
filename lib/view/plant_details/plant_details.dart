import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/expandable_text.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/data_types/place_data_model.dart';
import 'package:gardenia/view/google_maps/route_tracking_app.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../modules/data_types/plant.dart';

class PlantDetails extends StatelessWidget {

  final Plant plant;

  PlantDetails({super.key,
    required this.plant,
  });

  final List<String> characteristics = ['Careful', 'Place', 'Characteristics'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
      ),
      body: ListView(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(5),
                bottom: Radius.circular(30),
              )
            ),
            height: context.setHeight(4),
            width: double.infinity,
            child: Image.network(
              plant.image,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: plant.name,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Constants.appColor,
                    ),
                    CircleAvatar(
                      radius: 20.sp,
                      backgroundColor: Constants.secondAppColor.withOpacity(.5),
                      child: IconButton(
                          onPressed: () => context.normalNewRoute(const RouteTrackingApp()),
                          icon: Icon(Icons.location_on,color: Constants.appColor)
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    MyText(text: 'Type : ',fontWeight: FontWeight.bold,color: Constants.appColor,fontSize: 14.sp,),
                    MyText(
                      text: plant.type,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: MyExpandableText(
                    text: plant.description,
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
                    IconButton(
                        onPressed: ()
                        {
                          CategoriesCubit.getInstance(context).addToFav(plant);
                        },
                        icon: Icon(Icons.favorite_border,color: HexColor('0ACF83'),
                        ),
                    )
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
                                  horizontal: 18.w,
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: CategoriesCubit.getInstance(context).selectScreen(
                          carefulData:
                          [
                            {
                              'carefulSubTitle' : 'Light',
                              'icon' : plant.light!.contains('Full sun')?
                              const Icon(Icons.sunny,color: Colors.white) : const Icon(Icons.dark_mode_outlined,color: Colors.white),
                              'title' : plant.light!.split("/")[0],
                              'subTitle' : plant.light!.split("/")[1],
                            },
                            {
                              'carefulSubTitle' : 'Care',
                              'icon' : Image.asset(Constants.plantWater),
                              'title' : plant.careful!.split("/")[0],
                              'subTitle' : plant.careful!.split("/")[1],
                            },
                            {
                              'carefulSubTitle' : ' Fertilizer',
                              'icon' : const Icon(
                                Icons.group_work_rounded,
                                color: Colors.white,
                              ),
                              'title' : plant.liquid_fertilizer!,
                            },
                            {
                              'carefulSubTitle' : ' Clean',
                              'icon' : const Icon(
                                Icons.cleaning_services,
                                color: Colors.white,
                              ),
                              'title' : plant.clean!
                            },
                          ],
                          pLaceDataModel: PLaceDataModel(
                              resistanceZone: plant.resistance_zone!,
                              idealTemperature: plant.ideal_temperature!,
                              suitableLocation: plant.suitable_location!
                          ),
                          toxicity: plant.toxicity!,
                          names: plant.names!
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*
* Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                SizedBox(
                  width: 120.w,
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
          ),*/