import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/modules/app_widgets/app_button.dart';
import 'package:gardenia/modules/app_widgets/choose_payment_method_card.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/modules/data_types/checkout_invoice.dart';
import 'package:gardenia/view_model/categories/cubit.dart';

import '../../modules/app_widgets/arrow_back_button.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void showPaymentOptionsSheet()
  {
    scaffoldKey.currentState!.showBottomSheet((context) => Card(
          elevation: 5,
          child: ChoosingPaymentMethodCard()
        )
    );
  }

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
        leading: const ArrowBackButton(),
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
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                        obscureText: false,
                        hintText: 'Enter Cupon Code',
                        hintStyle: TextStyle(
                          fontSize: 14.sp
                        ),
                        controller: TextEditingController(),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                      child: AppButton(
                        onPressed: () {}, 
                        text: 'Apply', width: 7,
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(8),
                            left: Radius.circular(5),
                        ),
                      ),
                  )
                ],
              ),
            ),
            const Spacer(),
            AppButton(
                onPressed: () => showPaymentOptionsSheet(),
                text: 'Check out', width: 1,
            )
          ],
        ),
      ),
    );
  }
}
