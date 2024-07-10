import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:gardenia/model/remote/paypal_constants.dart';
import 'package:gardenia/model/remote/stripe/api_service/models/create_intent_input_model.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/stripe/cubit.dart';

class TestMode extends StatelessWidget {
  const TestMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          TextButton(
                onPressed: () => StripeCubit.getInstance(context).makePaymentProcess(inputModel: CreateIntentInputModel(amount: '100', currency: 'USD', customerId: 'cus_QRO74OeDrsV4D1')),
              child: MyText(text: 'test',)),
          TextButton(
              onPressed: ()
              {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckoutView(
                    sandboxMode: true,
                    clientId: PaypalConstants.paypalClientId,
                    secretKey: PaypalConstants.secretKey,
                    transactions: const [
                      {
                        "amount": {
                          "total": '100',
                          "currency": "USD",
                          "details": {
                            "subtotal": '100',
                            "shipping": '0',
                            "shipping_discount": 0
                          }
                        },
                        "description": "The payment transaction description.",
                        "item_list": {
                          "items": [
                            {
                              "name": "Apple",
                              "quantity": 4,
                              "price": '10',
                              "currency": "USD"
                            },
                            {
                              "name": "Pineapple",
                              "quantity": 5,
                              "price": '12',
                              "currency": "USD"
                            }
                          ],
                        }
                      }
                    ],
                    note: "Contact us for any questions on your order.",
                    onSuccess: (Map params) async {
                      log("onSuccess: $params");
                      Navigator.pop(context);
                    },
                    onError: (error) {
                      log("onError: $error");
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      print('cancelled:');
                      Navigator.pop(context);
                    },
                  ),
                ));
              },
              child: MyText(text: 'test',)),
        ],
      )),
    );
  }
}
