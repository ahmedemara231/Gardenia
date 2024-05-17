import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Favourite',fontSize: 20.sp,color: Constants.appColor,),
        centerTitle: true,
      ),
      body: CategoriesCubit.getInstance(context).favList.isEmpty?
      Center(
        child: MyText(text: 'No Favorites yet',fontWeight: FontWeight.w500,fontSize: 22.sp,),
      ) :
      BlocBuilder<CategoriesCubit,CategoriesStates>(
        buildWhen: (previous, current) => current is AddPlantToFavState || current is RemovePlantFromFavState,
        builder: (context, state) =>  GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 5.w,
              childAspectRatio: .8,
              crossAxisCount: 2
          ),
          itemBuilder: (context, index) => Card(
            elevation: 4,
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: 120.sp,
                    child: Image.network(
                      CategoriesCubit.getInstance(context).favList[index].image,
                      fit:  BoxFit.fill,
                    )
                ),
                Expanded(
                  child: ListTile(
                    title: MyText(
                      text: CategoriesCubit.getInstance(context).favList[index].name,
                      color: Constants.appColor,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: MyText(
                        text: CategoriesCubit.getInstance(context).favList[index].type
                    ),
                    trailing: IconButton(
                        onPressed: ()
                        {
                          CategoriesCubit.getInstance(context).removeFromFav(CategoriesCubit.getInstance(context).favList[index]);
                        },
                        icon: Icon(Icons.favorite,color: Constants.secondAppColor,)
                    ),
                  ),
                )
              ],
            ),
          ),
          itemCount: CategoriesCubit.getInstance(context).favList.length,
        ),
      ),
    );
  }
}
