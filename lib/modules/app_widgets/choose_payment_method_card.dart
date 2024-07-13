import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/local/secure_storage.dart';
import 'package:gardenia/view/payment/thank_you_view.dart';
import 'package:gardenia/view_model/stripe/states.dart';
import '../../constants/constants.dart';
import '../../model/remote/paypal/service.dart';
import '../../model/remote/stripe/api_service/models/create_intent_input_model.dart';
import '../../view/payment/payment_error_view.dart';
import '../../view_model/categories/cubit.dart';
import '../../view_model/stripe/cubit.dart';
import '../base_widgets/myText.dart';

class ChoosingPaymentMethodCard extends StatelessWidget {
  ChoosingPaymentMethodCard({super.key});

  final List<String> images =
  [
    'assets/images/visa.jpeg',
    'assets/images/paypal.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
            BlocBuilder<StripeCubit,StripeStates>(
              builder: (context, state) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length, (index) => InkWell(
                  onTap:()async {
                    final amount = (CategoriesCubit.getInstance(context).totalAmount + 40 + 120)*100;
                    switch(index)
                    {
                      case 0:
                        StripeCubit.getInstance(context).makePaymentProcess(
                          inputModel: CreateIntentInputModel(
                              amount: amount.toString(),
                              currency: 'USD',
                              customerId: await SecureStorage.getInstance().readData(key: 'customerId')??''
                          ),
                        ).then((value)
                        {
                          print(state);
                          if(state is StripePaymentSuccess)
                            {
                              context.replacementRoute(const ThankYouView());
                            }
                          else{
                            context.replacementRoute(const PaymentErrorView());
                          }
                        });
                      case 1:
                        PaypalService().makePaypalPaymentProcess(context);
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
            ),
          ],
        ),
      ),
    );
  }
}
