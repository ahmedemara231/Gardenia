import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/app_widgets/app_button.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';

import '../check_out/check_out.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int numberOfCopies = 0;

  @override
  void initState() {
    CategoriesCubit.getInstance(context).makeNumbersOfCopies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit,CategoriesStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: MyText(text: 'Your Cart',fontWeight: FontWeight.w500,),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: context.setHeight(1.35),
                child: ListView.separated(
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 55.w,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Image.network(
                              CategoriesCubit.getInstance(context).cartPlants[index].image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            children: [
                              SizedBox(
                                width : context.setWidth(4),
                                child: MyText(
                                  text: CategoriesCubit.getInstance(context).cartPlants[index].name,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              MyText(
                                text: '${CategoriesCubit.getInstance(context).cartPlants[index].price} EGP',
                                color: Constants.appColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () => CategoriesCubit.getInstance(context).removePlantFromCart(
                                  context,
                                  plant: CategoriesCubit.getInstance(context).cartPlants[index],
                                ),
                                icon: const Icon(Icons.delete_outline_sharp,color: Colors.grey,),
                              ),
                              Container(
                                width: context.setWidth(3),
                                height: 35.h,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                    shape: BoxShape.rectangle
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          CategoriesCubit.getInstance(context).removeCopy(index);
                                          }, icon: const Icon(Icons.remove)),
                                    MyText(text: CategoriesCubit.getInstance(context).numbersOfCopiesList[index].toString()),
                                    IconButton(
                                        onPressed: () {
                                          CategoriesCubit.getInstance(context).addCopy(index);
                                          }, icon: const Icon(Icons.add))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]
                      ),
                    )
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemCount: CategoriesCubit.getInstance(context).cartPlants.length,
                ),
              ),
              AppButton(
                  onPressed: () => context.normalNewRoute(const CheckOut()),
                  text: 'Make Invoice',
                  width: 1
              )
            ],
          ),
        ),
      ),
    );
  }
}
