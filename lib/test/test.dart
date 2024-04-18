import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/test/tff.dart';
import 'package:gardenia/view_model/sign_up/cubit.dart';
import 'package:gardenia/view_model/sign_up/states.dart';

import '../modules/base_widgets/textFormField.dart';

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  final nameCont = TextEditingController();

  final emailCont = TextEditingController();

  final passCont = TextEditingController();

  final passConfCont = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late List<Widget> signUpInputs;

  late Widget tff = TFF(
    obscureText: isObscure,
    controller: TextEditingController(),
    suffixIcon: IconButton(onPressed: () {
      isObscure = !isObscure;
      print(isObscure);
      setState(() {

      });
    },
      icon: isObscure?
      Icon(Icons.visibility_off) : Icon(Icons.visibility),
    ),

  );
  bool isObscure = true;
  @override
  void initState() {
    // tff = TFF(
    //   obscureText: isObscure,
    //   controller: TextEditingController(),
    //   suffixIcon: IconButton(onPressed: () {
    //     isObscure = !isObscure;
    //     print(isObscure);
    //     setState(() {
    //
    //     });
    //   },
    //     icon: isObscure?
    //     Icon(Icons.visibility_off) : Icon(Icons.visibility),
    //   ),
    //
    // );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
         [
          tff
         ]
      ),
    );
  }
}

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  final nameCont = TextEditingController();

  final emailCont = TextEditingController();

  final passCont = TextEditingController();

  final passConfCont = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late List<Widget> signUpInputs;

  @override
  void initState() {
    signUpInputs =
    [
      TFF(
        obscureText: false,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        hintText: 'Enter Your Username',
        controller: nameCont,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      TFF(
        hintText: 'Enter Your Email',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        obscureText: false,
        controller: emailCont,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      BlocBuilder<SignUpCubit,SignUpStates>(
        builder: (context, state) =>  TFF(
          hintText: 'Enter Your Password',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
            onPressed: ()
            {
              SignUpCubit.getInstance(context).changePasswordVisibility(0);
            },
            icon: SignUpCubit.getInstance(context).obscurePass[0]?
            const Icon(Icons.visibility_off):
            const Icon(Icons.visibility),
          ),
          obscureText: SignUpCubit.getInstance(context).obscurePass[0],
          controller: passCont,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
      BlocBuilder<SignUpCubit,SignUpStates>(
        builder: (context, state) =>  TFF(
          hintText: 'Conform Your Password',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
            onPressed: ()
            {
              SignUpCubit.getInstance(context).changePasswordVisibility(1);
            },
            icon: SignUpCubit.getInstance(context).obscurePass[1]?
            const Icon(Icons.visibility_off):
            const Icon(Icons.visibility),
          ),
          obscureText: SignUpCubit.getInstance(context).obscurePass[1],
          controller: passConfCont,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) => signUpInputs[index],
          itemCount: signUpInputs.length,
        ),
      ),
    );
  }
}

