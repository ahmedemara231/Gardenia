import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/app_widgets/app_button.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/categories/cubit.dart';

class ThankYouView extends StatefulWidget {
  const ThankYouView({super.key});

  @override
  State<ThankYouView> createState() => _ThankYouViewState();
}

class _ThankYouViewState extends State<ThankYouView> {

  // AwesomeDialog initDialog()
  // {
  //   return AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.success,
  //     animType: AnimType.rightSlide,
  //     title: 'Transfer Successful',
  //     btnCancelOnPress: () {},
  //     btnOkOnPress: () {},
  //   );
  // }

  @override
  void initState() {
    CategoriesCubit.getInstance(context).finishPayment(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 55.w),
              child: Column(
                children: [
                  Image.asset(Constants.appLogo),

                  MyText(
                    text: 'Transfer Successful',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: MyText(
                      text: 'Transfers are reviewed which may result in delays or funds being frozen',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2,),
            Container(
              decoration: BoxDecoration(
                color: Constants.appColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyText(
                  text: '${CategoriesCubit.getInstance(context).totalAmount} EGP',
                  fontSize: 32.sp,
                  color: Constants.appColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            AppButton(
                onPressed: () => Navigator.pop(context),
                text: 'Back to Home',
                width: 1
            )
          ],
        ),
      ),
    );
  }
}
