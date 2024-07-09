import 'package:flutter/material.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/stripe/cubit.dart';

class TestMode extends StatelessWidget {
  const TestMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextButton(onPressed: () => StripeCubit.getInstance(context).createPaymentIntent(amount: '100', currency: 'usd'), child: MyText(text: 'test',))),
    );
  }
}
