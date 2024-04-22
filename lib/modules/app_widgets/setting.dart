import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';

class SettingModel extends StatelessWidget {

  IconData optionIcon;
  String optionName;
  String value;

  SettingModel({super.key,
    required this.optionIcon,
    required this.optionName,
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 10.w),
      child: Row(
        children: [
          Icon(optionIcon),
          const SizedBox(width: 5),
          MyText(text: optionName,fontSize: 14.sp,),
          const Spacer(),
          if(value.isNotEmpty)
            MyText(text: value,color: Constants.appColor,)
        ],
      ),
    );
  }
}
