import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import '../../view/edit_post/edit_post.dart';

class Post extends StatelessWidget {

  int currentUserId;
  int postManagerId;
  String? userImageUrl;
  String userName;
  String? caption;
  String? postImage;
  int commentsNumber;
  void Function()? onPressed;
  void Function()? onSave;
  void Function()? onDelete;
  String time;


  Post({super.key,
    required this.currentUserId,
    required this.postManagerId,
    required this.userImageUrl,
    required this.userName,
    required this.postImage,
    required this.caption,
    required this.commentsNumber,
    required this.onPressed,
    required this.onSave,
    required this.onDelete,
    required this.time
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
           CircleAvatar(
             backgroundImage: NetworkImage(userImageUrl?? Constants.defaultProfileImage),
             radius: 22.sp,
           ),
            SizedBox(width: 10.w,),
            Column(
              children: [
                MyText(text: userName,fontSize: 16.sp,fontWeight: FontWeight.bold,),
                MyText(text: time),
              ],
            ),
            const Spacer(),
            PopupMenuButton(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white,width: 0)
              ),
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
                            child: MyText(
                              text: 'Save',
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              color: Constants.appColor,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.save_alt,color: Constants.appColor,)
                        ],
                      ),
                    ),
                    if(currentUserId == postManagerId)
                      PopupMenuItem(
                        onTap: () => context.normalNewRoute(EditPost()),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: MyText(
                                text: 'Edit',
                                fontSize: 15.sp,
                                color: Constants.appColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.edit,color: Constants.appColor,)
                          ],
                        ),
                      ),
                    if(currentUserId == postManagerId)
                      PopupMenuItem(
                      onTap: onDelete,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MyText(
                              text: 'Delete',
                              fontSize: 15.sp,
                              color: Constants.appColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.delete,color: Constants.appColor,)
                        ],
                      ),
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
              child: Image.file(File(postImage??''),fit: BoxFit.fill,),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: MyText(text: caption??'',fontSize: 16.sp),
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
