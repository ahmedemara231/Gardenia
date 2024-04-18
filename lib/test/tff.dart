import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/view_model/sign_up/cubit.dart';
import 'package:gardenia/view_model/sign_up/states.dart';

class TFF2 extends StatelessWidget {
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Color? prefixIconColor;
  Widget? suffixIcon;
  bool obscureText;
  var border;
  var enabledBorder;
  TextInputType? keyboardType;
  TextEditingController controller;
  void Function(String)? onChanged;
  void Function()? onPressed;
  void Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;
  TextStyle? style;

  TFF2({super.key,
    this.obscureText = false,
    required this.controller,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.keyboardType,
    this.onPressed,
    this.onChanged,
    this.onFieldSubmitted,
    this.border,
    this.enabledBorder,
    this.validator,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit,SignUpStates>(
      builder: (context, state) => TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        validator: validator?? (value)
        {
          if(value!.isEmpty)
          {
            return 'This Field is required';
          }
          return null;
        },
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        style: style?? const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500
        ),
        decoration: InputDecoration(
          border: border,
          enabledBorder: enabledBorder,
          hintText: hintText,
          hintStyle: hintStyle,
          labelText: labelText,
          labelStyle: labelStyle,
          prefixIcon: prefixIcon,
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: obscureText?Icon(Icons.add) : Icon(Icons.visibility_off),
          ),
          errorStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
