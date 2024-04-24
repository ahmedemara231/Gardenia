import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../constants/constants.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          ),
        ),
      ),

    ];
    super.initState();
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
              controller: RoundedLoadingButtonController(),
              onPressed: () {},
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
