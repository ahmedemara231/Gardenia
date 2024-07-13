import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/context.dart';
import '../../constants/constants.dart';
import '../../view_model/categories/cubit.dart';
import '../base_widgets/myText.dart';

class CartItem extends StatelessWidget {
  int index;

  CartItem({super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        index: index,
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
                                CategoriesCubit.getInstance(context).decCopy(index);
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
    );
  }
}
