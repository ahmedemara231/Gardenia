import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/categories/cubit.dart';
import 'package:gardenia/view_model/categories/states.dart';
import '../categories/search.dart';

class Test1 extends StatelessWidget {
  Test1({super.key});

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: MyText(text: 'test1'),),
      body: BlocBuilder<CategoriesCubit,CategoriesStates>(
        builder: (context, state) => Center(child: IconButton(onPressed: () => showSearch(context: context, delegate: Search()), icon: Icon(Icons.search)))
      ),
    );
  }
}
