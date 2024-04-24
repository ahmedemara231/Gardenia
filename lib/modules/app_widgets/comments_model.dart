import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';

class CommentsModel extends StatelessWidget {

  String? userImage;
  String userName;
  String comment;
  String time;
  int commentManagerId;
  int currentUserId;
  void Function()? onDelete;

  CommentsModel({super.key,
    required this.userImage,
    required this.userName,
    required this.comment,
    required this.time,
    required this.commentManagerId,
    required this.currentUserId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          userImage == null? Constants.defaultProfileImage :
          '${ApiConstants.baseUrlForImages}$userImage'
        ),
      ),
      title: MyText(
        text: userName,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(text: comment),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: MyText(
              text: time.substring(0,10),
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      trailing: currentUserId == commentManagerId? PopupMenuButton(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white,width: 0)
        ),
        itemBuilder: (context)
        {
          return
            [
                PopupMenuItem(
                  onTap: () {},
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
                PopupMenuItem(
                onTap: onDelete ,
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
      ) : null
    );
  }
}
