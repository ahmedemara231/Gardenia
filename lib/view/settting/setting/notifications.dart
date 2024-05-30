import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/view_model/setting/cubit.dart';
import 'package:gardenia/view_model/setting/states.dart';
import '../../../modules/app_widgets/arrow_back_button.dart';
import '../../../modules/base_widgets/myText.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});

  final List<String> notificationTypes = ['General Notification', 'Sound', 'Vibrate'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
        title: MyText(
            text: 'Notifications',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SettingCubit,SettingStates>(
          builder: (context, state) => Column(
            children: List.generate(
              notificationTypes.length, (index) =>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(text: notificationTypes[index],fontSize: 14.sp),
                    if(state is IsNotificationEnabledLoading)
                      const CircularProgressIndicator(),
                    if(state is !IsNotificationEnabledLoading)
                      Switch(
                      activeColor: Constants.appColor,
                      value: SettingCubit.getInstance(context).enabledNotifications[index],
                      onChanged: (value)
                      {
                        SettingCubit.getInstance(context).changeValue(index);
                      },
                    ),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}
