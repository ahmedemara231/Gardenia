import 'package:flutter/material.dart';
import 'package:gardenia/model/remote/stripe/api_service/models/create_intent_input_model.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/stripe/cubit.dart';

class TestMode extends StatelessWidget {
  const TestMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextButton(
            onPressed: () => StripeCubit.getInstance(context).makePaymentProcess(inputModel: CreateIntentInputModel(amount: '100', currency: 'USD', customerId: 'cus_QRO74OeDrsV4D1')),
          child: MyText(text: 'test',))),
    );
  }
}
