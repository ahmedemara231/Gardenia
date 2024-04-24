import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/view_model/categories/cubit.dart';

import '../../modules/app_widgets/app_button.dart';
import '../../modules/base_widgets/myText.dart';

class ErrorBuilder extends StatelessWidget {

  final String message;
  const ErrorBuilder({super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: MyText(text: message),
          ),
          AppButton(
            onPressed: () => CategoriesCubit.getInstance(context).getAllCategories(context),
            text: 'try again',
            width: 5,
          ),
        ],
      ),
    );;
  }
}
