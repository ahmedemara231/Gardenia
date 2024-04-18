import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../modules/base_widgets/myText.dart';

class ShimmerCommentsEffect extends StatelessWidget {
  const ShimmerCommentsEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            leading: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(''),
            ),
            title: MyText(
              text: '',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            subtitle: MyText(text: ''),
            trailing: MyText(
              text: '',
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          separatorBuilder:(context, index) => SizedBox(height: 10.h,) ,
          itemCount: 10
      ),
    );
  }
}
