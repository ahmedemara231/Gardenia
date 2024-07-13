import 'package:flutter/material.dart';
import 'package:gardenia/constants/constants.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key,
    this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed?? () {Navigator.pop(context);},
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Constants.appColor,
        ),
    );
  }
}
