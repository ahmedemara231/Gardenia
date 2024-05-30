import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/modules/data_types/permission_process.dart';
import 'package:gardenia/modules/methods/check_permission.dart';
import 'package:gardenia/view_model/setting/states.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingCubit extends Cubit<SettingStates>
{
  SettingCubit() : super(SettingInitial());

  factory SettingCubit.getInstance(context) => BlocProvider.of(context);

  Future<void> handleCallingStore(context)async
  {
    checkPermission(
        PermissionProcessModel(
          permissionClient: PermissionClient.contacts,
          onPermissionGranted: () => callTheStore(),
          onPermissionDenied: () {
            MyToast.showToast(
                context,
                msg: 'Enable Contacts to contact with us',
                color: Colors.red
            );
          }
        )
    );
  }

  Future<void> callTheStore() async {
    await launchUrl(Uri.parse('tel:+1-555-010-999'));
  }

  late bool notificationEnabled;
  late List<bool> enabledNotifications;
  Future<void> isNotificationEnabled()async
  {
    emit(IsNotificationEnabledLoading());
    Permission.notification.status.isGranted.then((result)
    {
      notificationEnabled = result;
      enabledNotifications = [result,false,false];
      emit(NotificationEnabledResult());
    });
  }

  Future<void> changeValue(int index)async
  {
    if(index == 0)
      {
        if(!notificationEnabled)
          {
            await checkPermission(
                PermissionProcessModel(
                  permissionClient: PermissionClient.notification,
                  onPermissionGranted: () {}, onPermissionDenied: () {},
                ),
            );
          }
      }
    enabledNotifications[index] = !enabledNotifications[index];
    emit(ChangeValue());
  }

  Future<void> shareApp(context)async
  {
    final result = await Share.shareWithResult('check out my website https://example.com');

    if (result.status == ShareResultStatus.success) {
      MyToast.showToast(
          context,
          msg: 'Thanks',
          color: Constants.appColor
      );
    }
  }

}