import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view/profile/edit_profile/edit_profile.dart';
import 'package:gardenia/view/settting/setting/notifications.dart';
import 'package:gardenia/view/settting/setting/privacy_policy.dart';
import 'package:gardenia/view_model/setting/cubit.dart';
import 'package:gardenia/view_model/setting/states.dart';
import 'package:gardenia/view_model/update_profile/states.dart';
import '../../model/remote/api_service/service/constants.dart';
import '../../modules/app_widgets/setting.dart';
import '../../view_model/profile/cubit.dart';
import '../../view_model/update_profile/cubit.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List settings =
  [
    SettingModel(optionIcon: Icons.edit_sharp, optionName: 'Edit profile information'),
    BlocBuilder<SettingCubit,SettingStates>(
      builder: (context, state) =>
          SettingModel(
            optionIcon: Icons.notifications_active_outlined,
            optionName: 'Notifications',
            value: state is !IsNotificationEnabledLoading? SettingCubit.getInstance(context).enabledNotifications[0]?
            'ON' : 'OFF'
            : 'Load..'
          ),
    ),
    SettingModel(optionIcon: Icons.share, optionName: 'Share App',),

    SettingModel(optionIcon: Icons.security, optionName: 'security'),
    SettingModel(optionIcon: Icons.dark_mode_outlined, optionName: 'Theme',value: 'Light Mode'),

    SettingModel(optionIcon: Icons.help_outline_outlined, optionName: 'Help & Support'),
    SettingModel(optionIcon: Icons.contact_page_outlined, optionName: 'Contact Us'),
    SettingModel(optionIcon: Icons.privacy_tip_outlined, optionName: 'Privacy policy'),
  ];

  @override
  void initState() {
    SettingCubit.getInstance(context).isNotificationEnabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const ArrowBackButton(),
        title: MyText(
          text: 'Setting',
          color: Constants.appColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: double.infinity,
                height: context.setHeight(2.5),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 70.h),
                  child: Image.asset(
                    Constants.profileBackgroundImage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              BlocBuilder<UpdateProfileCubit,UpdateProfileStates>(
                builder: (context, state) =>  Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children:
                      [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius : 50.sp,
                            backgroundImage:
                            NetworkImage(
                                '${ApiConstants.baseUrlForImages}${ProfileCubit.getInstance(context).profileData.data?['image']}'
                            )
                          ),
                        ),
                        IconButton(
                          onPressed: () async
                          {
                            await UpdateProfileCubit.getInstance(context).selectNewProfileImage(context);
                          },
                          icon: Image.asset(Constants.penProfileIcon),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      child: MyText(
                          text: ProfileCubit.getInstance(context).profileData.data?['username'],
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Constants.appColor
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: List.generate(
                        settings.sublist(0,3).length,
                            (index) => InkWell(
                              onTap: ()
                              {
                                switch(index)
                                {
                                  case 0:
                                    context.normalNewRoute(EditProfile());
                                  case 1 :
                                    context.normalNewRoute(Notifications());
                                  case 2 :
                                    SettingCubit.getInstance(context).shareApp(context);
                                }
                              },
                              child: settings.sublist(0,3)[index],
                            )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Card(
                    child: Column(
                      children: List.generate(
                          settings.sublist(3,5).length,
                              (index) => settings.sublist(3,5)[index]
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    children: List.generate(
                        settings.sublist(5,8).length,
                            (index) => InkWell(
                              onTap: ()
                              {
                                switch(index)
                                {
                                  case 0:
                                    SettingCubit.getInstance(context).handleCallingStore(context);
                                  case 1:
                                    SettingCubit.getInstance(context).handleCallingStore(context);
                                  case 2:
                                    context.normalNewRoute(PrivacyPolicy());
                                }
                              }, child: settings.sublist(5,8)[index],
                            )
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
