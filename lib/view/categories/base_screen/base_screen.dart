import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/view/cart/cart.dart';
import 'package:gardenia/view/categories/all/categories.dart';
import 'package:gardenia/view/categories/search.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';
import '../specific_category/specific_category.dart';

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
    categoriesCubit.open();
    super.initState();
  }

  List<String> tabsName = ['All', 'Indoor', 'Outdoor', ' Garden', 'Office'];

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
              IconButton(
                  onPressed: () => context.normalNewRoute(const Cart()),
                  icon: const Icon(Icons.shopping_cart
                  ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${ApiConstants.baseUrlForImages}${CacheHelper.getInstance().getUserData()![3]}'),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
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
                        onPressed: () => showSearch(context: context, delegate: Search()),
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
                      onTap: (newTap) => categoriesCubit.changeTab(newTap),
                      tabs: List.generate(
                          tabsName.length,
                              (index) => Tab(
                            child: MyText(
                                text: tabsName[index],
                                color: Constants.appColor,
                                fontSize: 10.sp ,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      ),
                    ),
                  ),
                  BlocBuilder<CategoriesCubit,CategoriesStates>(
                    builder: (context, state) => SizedBox(
                      height: context.setHeight(1.4),
                      child: const TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children:
                        [
                          AllCategories(),
                          SpecificCategory(),
                          SpecificCategory(),
                          SpecificCategory(),
                          SpecificCategory(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
