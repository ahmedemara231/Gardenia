import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/modules/myText.dart';

class Post extends StatelessWidget {

  String userImageUrl;
  String userName;
  String postImage;
  String caption;
  int commentsNumber;
  void Function()? onPressed;
  void Function()? onSave;


  Post({super.key,
    required this.userImageUrl,
    required this.userName,
    required this.postImage,
    required this.caption,
    required this.commentsNumber,
    required this.onPressed,
    required this.onSave,
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
            SizedBox(width: 10.w,),
            MyText(text: userName,fontSize: 16.sp,fontWeight: FontWeight.bold,),
            const Spacer(),
            PopupMenuButton(
              itemBuilder: (context)
              {
                return
                  [
                    PopupMenuItem(
                      onTap: onSave,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MyText(text: 'Save'),
                          ),
                           const Icon(Icons.save_alt,color: Colors.black54,)
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MyText(text: 'Delete Post'),
                          ),
                          Icon(Icons.delete,color: Colors.red[400],)
                        ],
                      ),
                      onTap: () {},
                    ),
                  ];
              },
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.h),
          child: SizedBox(
              width: context.setWidth(1.1),
              child: Image.network(postImage,fit: BoxFit.fill,),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: MyText(text: caption,fontSize: 16.sp),
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
