import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/repositories/put_patch_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/modules/data_types/update_user_data.dart';
import 'package:gardenia/modules/data_types/user_data.dart';
import 'package:gardenia/view_model/profile/cubit.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../constants/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  final nameCont = TextEditingController();

  final emailCont = TextEditingController();

  final passCont = TextEditingController();

  final confirmPassCont = TextEditingController();


  late List<Container> data;
  List<String> dataNames = ['User name', 'email', 'Password', 'confirm password'];
  @override
  void initState() {

    nameCont.text = CacheHelper.getInstance().getUserData()![1];
    emailCont.text = CacheHelper.getInstance().getUserData()![2];

    data =
    [
      Container(
        color: Colors.grey[200],
        child: TFF(
          obscureText: false,
          controller: nameCont,
          onChanged: (newLetter) {setState(() {});},
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)
          ),
        ),
      ),
      Container(
        color: Colors.grey[200],
        child: TFF(
          obscureText: false,
          controller: emailCont,
          onChanged: (newLetter) {setState(() {});},
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          ),
        ),
      ),
      Container(
        color: Colors.grey[200],
        child: TFF(
          obscureText: false,
          controller: passCont,
          onChanged: (newLetter) {setState(() {});},
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          ),
        ),
      ),
      Container(
        color: Colors.grey[200],
        child: TFF(
          obscureText: false,
          controller: confirmPassCont,
          onChanged: (newLetter) {setState(() {});},
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          ),
        ),
      ),

    ];
    super.initState();
  }

  @override
  void dispose() {
    nameCont.dispose();
    emailCont.dispose();
    passCont.dispose();
    confirmPassCont.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
        title: MyText(
          text: 'Edit profile',
          color: Constants.appColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: [
            Column(
              children: List.generate(
                  data.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(text: dataNames[index]),
                            const SizedBox(height: 5),
                            data[index],
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: context.setHeight(8),
            ),
            RoundedLoadingButton(
              color: Constants.appColor,
              controller: controller,
              onPressed:
              nameCont.text == CacheHelper.getInstance().getUserData()![1]&&
                  emailCont.text == CacheHelper.getInstance().getUserData()![2]&&
                  passCont.text.isEmpty&& confirmPassCont.text.isEmpty?
                  null: ()async
              {
                    if(confirmPassCont.text != passCont.text)
                    {
                      MyToast.showToast(
                          context,
                          msg: 'Password Should be the same',
                          color: Colors.red
                      );
                    }
                    else{
                      await ProfileCubit.getInstance(context).editUserData(
                        context, UpdateUserData(
                          name: nameCont.text,
                          email: emailCont.text,
                          pass: passCont.text,
                          confirmPass: confirmPassCont.text
                      ),);

                      controller.success();

                      // if(passCont.text.isEmpty)
                      // {
                      //   ProfileCubit.getInstance(context).editUserData(
                      //     context, UpdateUserData(
                      //       name: nameCont.text,
                      //       email: emailCont.text,
                      //       pass: null,
                      //       confirmPass: confirmPassCont.text
                      //   ),);
                      // }
                      // else{
                      //   ProfileCubit.getInstance(context).editUserData(
                      //     context, UpdateUserData(
                      //       name: nameCont.text,
                      //       email: emailCont.text,
                      //       pass: passCont.text,
                      //       confirmPass: confirmPassCont.text
                      //   ),);
                      // }
                    }

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
          ],
        ),
      ),
    );
  }
}
