import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/snackBar.dart';
import 'package:gardenia/modules/data_types/user_data.dart';
import 'package:gardenia/view/auth/login/login.dart';
import 'package:gardenia/view_model/sign_up/cubit.dart';
import 'package:gardenia/view_model/sign_up/states.dart';
import '../../../modules/app_widgets/auth_components.dart';
import '../../../modules/base_widgets/textFormField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

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
  void dispose() {
    nameCont.dispose();
    emailCont.dispose();
    passCont.dispose();
    passConfCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Image.asset(Constants.appLogo),
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
                      if(passCont.text == passConfCont.text)
                        {
                          SignUpCubit.getInstance(context).signUp(
                            context,
                            user: UserData(
                              name: nameCont.text,
                              email: emailCont.text,
                              password: passCont.text,
                              conformPass: passConfCont.text,
                            ),
                          );
                        }
                      else{
                        SignUpCubit.getInstance(context).signUpButtonCont.reset();
                        MySnackBar.showSnackBar(
                            context: context,
                            message: 'The password should be the same',
                            color: Colors.red,
                        );
                      }
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
