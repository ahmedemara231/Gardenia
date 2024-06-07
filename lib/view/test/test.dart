import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';
import 'package:gardenia/view_model/categories/states.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:gardenia/view_model/setting/cubit.dart';
import 'package:gardenia/view_model/setting/states.dart';

class Test1 extends StatelessWidget {
  Test1({super.key});

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: MyText(text: 'test1'),),
      body: BlocBuilder<CategoriesCubit,CategoriesStates>(
        builder: (context, state) => Column(
          children: [

            IconButton(onPressed: () {
      },
                icon: Icon(Icons.route)),

          ],
        )
      ),
    );
  }
}

// class Test2 extends StatelessWidget {
//   Test2({super.key});
//
//   bool obscureText = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: MyText(text: 'test2'),),
//       body: BlocBuilder<CategoriesCubit,CategoriesStates>(
//         builder: (context, state) => Column(
//           children: [
//             MyText(text: CategoriesCubit.getInstance(context).num2.toString()),
//             IconButton(onPressed: () => CategoriesCubit.getInstance(context).inc(), icon: Icon(Icons.add)),
//             IconButton(onPressed: () => context.normalNewRoute(Test2()), icon: Icon(Icons.route))
//
//           ],
//         )
//       ),
//     );
//   }
// }
