import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyExpandableText extends StatelessWidget {

  final String? text;
  const MyExpandableText({super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      text?? '',
      style: TextStyle(fontSize: 16.sp,color: Colors.black),
      linkTextStyle: const TextStyle(color: Colors.blue),
      trimType: TrimType.lines,
      trim: 2,
      readMoreText: 'show more',
      readLessText: 'show less',
    );
  }
}
