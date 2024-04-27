import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyExpandableText extends StatelessWidget {

  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  const MyExpandableText({super.key,
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      text?? '',
      style: TextStyle(
        fontSize: size?? 16.sp,
        color: color?? Colors.black,
        fontWeight: fontWeight
      ),
      linkTextStyle: const TextStyle(color: Colors.blue),
      trimType: TrimType.lines,
      trim: 2,
      readMoreText: 'show more',
      readLessText: 'show less',
    );
  }
}
