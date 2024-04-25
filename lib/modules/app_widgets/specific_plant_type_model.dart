import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../modules/base_widgets/myText.dart';

class ItemBuilder extends StatelessWidget {
  String image;
  String name;
  String type;

  ItemBuilder({super.key,
    required this.image,
    required this.name,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27)
      ),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 120.h,
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MyText(
                      text: name,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    MyText(
                      text: type,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
