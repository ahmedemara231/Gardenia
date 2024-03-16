import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/modules/myText.dart';
import 'package:gardenia/modules/widgets/auth_components.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view_model/sign_up/cubit.dart';
import 'package:gardenia/view_model/sign_up/states.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../modules/textFormField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final nameCont = TextEditingController();
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  final phoneCont = TextEditingController();
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
      TFF(
        hintText: 'Enter Your Phone Number',
        obscureText: false,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        controller: phoneCont,
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
              SignUpCubit.getInstance(context).changePasswordVisibility();
            },
            icon: SignUpCubit.getInstance(context).isVisible?
            const Icon(Icons.visibility_off):
            const Icon(Icons.visibility),
          ),
          obscureText: SignUpCubit.getInstance(context).isVisible,
          controller: passCont,
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Image.asset('images/app_logo.png'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: MyText(
                  text: 'Create an account',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: List.generate(signUpInputs.length, (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: signUpInputs[index],
                  ),
                  ),
                ),
              ),
        
              AuthComponents(
                btnController: SignUpCubit.getInstance(context).signUpButtonCont,
                signUpOrIn: 'Login',
                buttonName: 'Sign up',
                onPressed: ()
                {
                  if(formKey.currentState!.validate())
                    {
                      SignUpCubit.getInstance(context).signUp(context);
                    }
                  else{
                    SignUpCubit.getInstance(context).signUpButtonCont.reset();
                  }
                },
                otherOptionText: 'Already have an account',
                newRoute: Login(),
                navigationMethod: 'remove',
              )
            ],
          ),
        ),
      ),
    );
  }
}
