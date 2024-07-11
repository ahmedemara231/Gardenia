import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/model/remote/paypal/models/item.dart';
import 'package:gardenia/modules/app_widgets/app_button.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/stripe/cubit.dart';
import '../../model/remote/paypal/models/amount.dart';
import '../../model/remote/paypal/paypal_constants.dart';
import '../../model/remote/stripe/api_service/models/create_intent_input_model.dart';

// in payment details screen
class BuyNowButton extends StatelessWidget {

  final String amount;
  List<Item> items;

  BuyNowButton({super.key,
    required this.amount,
    required this.items,
  });

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> images =
  [
    'assets/images/visa.jpeg',
    'assets/images/paypal.jpeg',
  ];

  void paypalPayment(context){
    AmountModel amountModel = AmountModel(
        total: amount,
        details: Details(
            subTotal: amount,
            shipping: '0',
            shipping_discount: 0
        ),
    );

    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: PaypalConstants.paypalClientId,
        secretKey: PaypalConstants.secretKey,
        transactions: [
          {
            "amount": amountModel.toJson(),
            "description": "From Gardenia Store",
            "item_list": {
              "items": items.map((e) => e.toJson()).toList()
              // [
              //   {
              //     "name": "Apple",
              //     "quantity": 4,
              //     "price": '10',
              //     "currency": "USD"
              //   },
              //   {
              //     "name": "Pineapple",
              //     "quantity": 5,
              //     "price": '12',
              //     "currency": "USD"
              //   }
              // ],
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
  }

  void showPaymentOptionsSheet()
  {
    scaffoldKey.currentState!.showBottomSheet(
            (context) => Card(
              elevation: 5,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Constants.appColor),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyText(
                        text: 'Choose Payment Method',
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Constants.appColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          images.length, (index) => InkWell(
                          onTap:() {
                            switch(index)
                            {
                              case 0:
                                StripeCubit.getInstance(context).makePaymentProcess(
                                    inputModel: CreateIntentInputModel(
                                        amount: '${amount}00',
                                        currency: 'USD',
                                        customerId: 'cus_QRO74OeDrsV4D1'
                                    ),
                                );
                              case 1:
                                paypalPayment(context);
                            }
                          },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                  width: 100.w,
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Constants.appColor)
                                  ),
                                  child: Image.asset(images[index])),
                            ),
                          ),),
                      ),
                    ],
                  ),
                ),
              ),
            )
    );
  }

  List<Item> itemss = [
    Item(name: 'name', quantity: 2, price: '100'),
    Item(name: 'name', quantity: 4, price: '200'),
    Item(name: 'name', quantity: 3, price: '150'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: AppButton(
          onPressed: () =>
              showPaymentOptionsSheet(),
          text: 'Buy',
          width: 1.2,
        ),
      ),
    );
  }
}
