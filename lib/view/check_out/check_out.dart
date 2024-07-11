import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/modules/app_widgets/app_button.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/modules/data_types/checkout_invoice.dart';
import 'package:gardenia/view_model/categories/cubit.dart';

import '../../constants/constants.dart';
import '../../model/remote/paypal/models/amount.dart';
import '../../model/remote/paypal/paypal_constants.dart';
import '../../model/remote/stripe/api_service/models/create_intent_input_model.dart';
import '../../view_model/stripe/cubit.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> images =
  [
    'assets/images/visa.jpeg',
    'assets/images/paypal.jpeg',
  ];

  void paypalPayment(context){
    AmountModel amountModel = AmountModel(
      total: CategoriesCubit.getInstance(context).totalAmount.toString(),
      details: Details(
          subTotal: CategoriesCubit.getInstance(context).totalAmount.toString(),
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
      ),
    ));
  }

  void showPaymentOptionsSheet()
  {
    scaffoldKey.currentState!.showBottomSheet((context) => Card(
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
                        final amount = (CategoriesCubit.getInstance(context).totalAmount + 40 + 120)*100;
                        switch(index)
                        {
                          case 0:
                            StripeCubit.getInstance(context).makePaymentProcess(
                              inputModel: CreateIntentInputModel(
                                  amount: amount.toString(),
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


  List<String> titles =
  [
    'items',
    'shipping',
    'import charges',
    'Total price'
  ];

  late List<InvoiceItem> invoice;
  @override
  void initState() {
    CategoriesCubit.getInstance(context).executeCheckoutProcess();
    invoice = [
      InvoiceItem(
          title: 'items (${CategoriesCubit.getInstance(context).plantsItems.length})',
          value: CategoriesCubit.getInstance(context).totalAmount.toString(),
      ),
      InvoiceItem(
        title: 'Shipping',
        value: 40.toString(),
      ),
      InvoiceItem(
        title: 'import charges',
        value: 120.toString(),
      ),
      InvoiceItem(
        title: 'Total price',
        value:'${CategoriesCubit.getInstance(context).totalAmount+40+120}',
      )
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: MyText(text: 'Check out',fontWeight: FontWeight.w500,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: List.generate(
                      invoice.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                MyText(
                                  text: invoice[index].title,
                                  fontWeight: index == 3? FontWeight.bold : null,
                                ),
                                const Spacer(),
                                MyText(
                                  text: invoice[index].value!,
                                  fontWeight: index == 3? FontWeight.bold : null,
                                )
                              ],
                            ),
                          )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40.h,
                      child: TFF(
                        obscureText: false,
                        controller: TextEditingController(),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                      child: AppButton(onPressed: () {}, text: 'Apply', width: 7))
                ],
              ),
            ),
            const Spacer(),
            AppButton(onPressed: () => showPaymentOptionsSheet(), text: 'Check out', width: 1)
          ],
        ),
      ),
    );
  }
}
