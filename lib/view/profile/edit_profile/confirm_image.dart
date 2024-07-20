import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/view_model/update_profile/cubit.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../constants/constants.dart';
import '../../../modules/base_widgets/myText.dart';

class ConfirmImage extends StatelessWidget {

  const ConfirmImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 100.sp,
            backgroundImage: FileImage(UpdateProfileCubit.getInstance(context).newProfileImage!),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: RoundedLoadingButton(
              color: Constants.appColor,
              controller: UpdateProfileCubit.getInstance(context).updateImageBtnCont,
              onPressed: () async
              {
                await UpdateProfileCubit.getInstance(context).updateProfileImage(context);
              },
              borderRadius: 12,
              child: SizedBox(
                width: context.setWidth(1.1),
                child: Center(
                  child: MyText(
                    text: 'Save',
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
