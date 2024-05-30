import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/app_widgets/privacy_policy.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});

  final Map<String,String> privacyPolicy =
  {
    PrivacyPolicyConstants.keyOne : PrivacyPolicyConstants.valueOne,
    PrivacyPolicyConstants.keyTwo : PrivacyPolicyConstants.valueTwo,
    PrivacyPolicyConstants.keyThree : PrivacyPolicyConstants.valueThree,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
        title: MyText(
            text: 'Privacy Policy',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h,horizontal: 20.w),
            child: PrivacyPolicyModel(
                title: privacyPolicy.keys.toList()[index],
                value: privacyPolicy.values.toList()[index]
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemCount: privacyPolicy.length
      ),
    );
  }
}

class PrivacyPolicyConstants
{
  static const String keyOne = '1. Types data we collect';
  static const String valueOne = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.';

  static const String keyTwo = '2. Use of your personal data';
  static const String valueTwo = 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae.Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.';

  static const String keyThree = '3. Disclosure of your personal data';
  static const String valueThree = 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. ';
}
