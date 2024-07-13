import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/remote/paypal/paypal_constants.dart';

import '../../../view_model/categories/cubit.dart';
import 'models/amount.dart';

class PaypalService
{
  Future<void> makePaypalPaymentProcess(BuildContext context)async
  {
      AmountModel amountModel = AmountModel(
        total: CategoriesCubit.getInstance(context).totalAmount.toString(),
        details: Details(
            subTotal: CategoriesCubit.getInstance(context).totalAmount.toString(),
            shipping: '0',
            shipping_discount: 0
        ),
      );

      context.normalNewRoute(PaypalCheckoutView(
        sandboxMode: true,
        clientId: PaypalConstants.paypalClientId,
        secretKey: PaypalConstants.secretKey,
        transactions: [
          {
            "amount": amountModel.toJson(),
            "description": "From Gardenia Store",
            "item_list": {
              "items": CategoriesCubit.getInstance(context).plantsItems.map((e) => e.toJson()).toList()
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
          log('cancelled:');
          Navigator.pop(context);
        },
      ));
  }
}