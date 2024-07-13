import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/app_widgets/app_button.dart';
import 'package:gardenia/modules/app_widgets/cart_item.dart';
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
        body:
        CategoriesCubit.getInstance(context).cartPlants.isEmpty?
        Center(
            child: MyText(
              text: 'Your cart is empty',
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            )
        ):
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: context.setHeight(1.35),
                child: ListView.separated(
                  itemBuilder: (context, index) => CartItem(index: index),
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
