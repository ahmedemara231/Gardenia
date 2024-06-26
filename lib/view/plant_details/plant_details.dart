import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/expandable_text.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/data_types/place_data_model.dart';
import 'package:gardenia/view/google_maps/map_view.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../modules/data_types/plant.dart';
import 'characteristics/carful/carful.dart';
import 'characteristics/characteristics/characteristics.dart';
import 'characteristics/place/place.dart';

class PlantDetails extends StatefulWidget {

  final Plant plant;

  const PlantDetails({super.key,
    required this.plant,
  });

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  final List<String> characteristicsNames = ['Careful', 'Place', 'Characteristics'];
  PageController controller = PageController();

  late List<Widget> characteristics;
  void initCharacteristics({
    required List<Map<String,dynamic>> carefulData,
    required PLaceDataModel pLaceDataModel,
    required String toxicity,
    required String names,
  })
  {
    characteristics = [
      Careful(carefulData: carefulData),
      Place(pLaceDataModel: pLaceDataModel),
      Characteristics(toxicity: toxicity, names: names)
    ];
  }

  @override
  void initState() {
    // CategoriesCubit.getInstance(context).getFavPlants();
    initCharacteristics(
        carefulData: [
      {
        'carefulSubTitle' : 'Light',
        'icon' : widget.plant.light!.contains('Full sun')?
        const Icon(Icons.sunny,color: Colors.white) : const Icon(Icons.dark_mode_outlined,color: Colors.white),
        'title' : widget.plant.light!.split("/")[0],
        'subTitle' : widget.plant.light!.split("/")[1],
      },
      {
        'carefulSubTitle' : 'Care',
        'icon' : Image.asset(Constants.plantWater),
        'title' : widget.plant.careful!.split("/")[0],
        'subTitle' : widget.plant.careful!.split("/")[1],
      },
      {
        'carefulSubTitle' : ' Fertilizer',
        'icon' : const Icon(
          Icons.group_work_rounded,
          color: Colors.white,
        ),
        'title' : widget.plant.liquid_fertilizer!,
      },
      {
        'carefulSubTitle' : ' Clean',
        'icon' : const Icon(
          Icons.cleaning_services,
          color: Colors.white,
        ),
        'title' : widget.plant.clean!
      },
    ],
        pLaceDataModel: PLaceDataModel(
            resistanceZone: widget.plant.resistance_zone!,
            idealTemperature: widget.plant.ideal_temperature!,
            suitableLocation: widget.plant.suitable_location!
        ),
        toxicity: widget.plant.toxicity!,
        names: widget.plant.names!
    );
    super.initState();
  }
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
              widget.plant.image,
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
                      text: widget.plant.name,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Constants.appColor,
                    ),
                    CircleAvatar(
                      radius: 20.sp,
                      backgroundColor: Constants.secondAppColor.withOpacity(.5),
                      child: IconButton(
                          onPressed: () => context.normalNewRoute(const MapView()),
                          icon: Icon(Icons.location_on,color: Constants.appColor)
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    MyText(text: 'Type : ',fontWeight: FontWeight.bold,color: Constants.appColor,fontSize: 14.sp,),
                    MyText(
                      text: widget.plant.type,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: MyExpandableText(
                    text: widget.plant.description,
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
                    BlocBuilder<CategoriesCubit,CategoriesStates>(
                      builder: (context, state) =>
                      state is GetFavListLoading?
                      SizedBox(
                          width: 18.w,
                          height: 18.h,
                          child: const CircularProgressIndicator()
                      ) :
                      IconButton(
                        onPressed: ()async
                        {
                          await CategoriesCubit.getInstance(context).addRemFavorites(
                            context,
                            page: CurrentPage.plantDetails,
                            plantId: widget.plant.id,
                            plant: widget.plant
                          );
                        },
                        icon:
                        CategoriesCubit.getInstance(context).favList.contains(widget.plant)?
                        Icon(Icons.favorite, color: Constants.appColor):
                        Icon(Icons.favorite_border,color: HexColor('0ACF83')),
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
                            characteristicsNames.length,
                                (newCharTap) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.w,
                                  vertical: 14.h
                              ),
                              child: InkWell(
                                onTap: ()
                                {
                                  CategoriesCubit.getInstance(context).changeCharTab(newCharTap);
                                  controller.animateToPage(
                                      newCharTap,
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.fastOutSlowIn
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color:
                                      CategoriesCubit.getInstance(context).currentTab == newCharTap?
                                      HexColor('0ACF83') :
                                      null
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 7.h,
                                        horizontal: 12.w
                                    ),
                                    child: MyText(
                                        text: characteristicsNames[newCharTap],
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
                        text: characteristicsNames[CategoriesCubit.getInstance(context).currentTab],
                        fontSize: 25.sp,
                      ),
                      SizedBox(
                        height: context.setHeightForCharPages(CategoriesCubit.getInstance(context).currentTab),
                        child: PageView.builder(
                          controller: controller,
                          onPageChanged: (newPageIndex) {
                            CategoriesCubit.getInstance(context).changeCharTab(newPageIndex);
                          },
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: characteristics[index],
                          ),
                          itemCount: characteristics.length,
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