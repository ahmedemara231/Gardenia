import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/view_model/setting/cubit.dart';
import 'package:gardenia/view_model/setting/states.dart';

class Test extends StatelessWidget {
  Test({super.key});

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: BlocBuilder<SettingCubit,SettingStates>(
      //   builder: (context, state) => TFF(
      //     obscureText: obscureText,
      //     controller: TextEditingController(),
      //     onPressed: () {
      //       obscureText = !obscureText;
      //       SettingCubit.getInstance(context).changeObs();
      //     },
      //   ),
      // ),
    );
  }
}
