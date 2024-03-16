import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/modules/myText.dart';

class Post extends StatelessWidget {

  String userImageUrl;
  String userName;
  String postImage;
  String caption;
  int commentsNumber;
  void Function()? onPressed;

  Post({super.key,
    required this.userImageUrl,
    required this.userName,
    required this.postImage,
    required this.caption,
    required this.commentsNumber,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
           CircleAvatar(
             backgroundImage: NetworkImage(userImageUrl),
             radius: 22.sp,
           ),
            const SizedBox(width: 10,),
            MyText(text: userName,fontSize: 16.sp,fontWeight: FontWeight.bold,),
          ],
        ),
        Image.network(postImage,fit: BoxFit.contain,),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: MyText(text: caption,fontSize: 16.sp),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.mode_comment_outlined,color: Colors.grey,),
            ),
            MyText(text: '$commentsNumber',color: Colors.grey,),
          ],
        )
      ],
    );
  }
}
