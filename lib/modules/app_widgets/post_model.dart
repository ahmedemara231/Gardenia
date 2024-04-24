import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import '../../view/home/post_comments.dart';

class Post extends StatelessWidget {

  int? id;
  int currentUserId;
  int postManagerId;
  String? userImageUrl;
  String userName;
  String? caption;
  String? postImage;
  int commentsNumber;
  String time;
  void Function()? onEditClick;

  Post({super.key,
    this.id,
    required this.currentUserId,
    required this.postManagerId,
    required this.userImageUrl,
    required this.userName,
    required this.postImage,
    required this.caption,
    required this.commentsNumber,
    required this.time,
    this.onEditClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                userImageUrl == null || userImageUrl!.isEmpty?
                Constants.defaultProfileImage :
                '${ApiConstants.baseUrlForImages}$userImageUrl'
            ),
            radius: 22.sp,
          ),
          title:  MyText(text: userName,fontSize: 16.sp,fontWeight: FontWeight.bold,),
          subtitle: MyText(text: time),
          trailing: PopupMenuButton(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white,width: 0)
            ),
            itemBuilder: (context)
            {
              return
                [
                  PopupMenuItem(
                    onTap: ()
                    {
                      // homeCubit.addToFavorites(
                      //   homeCubit.fakePosts[index],
                      // );
                    },
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
                      onTap: onEditClick,
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
                      onTap: () async{
                        await HomeCubit.getInstance(context).deletePost(
                          context,
                          postId: id!,
                        );
                      },
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
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.h),
          child: postImage == null? const SizedBox() :
          SizedBox(
              child: Image.network(
                '${ApiConstants.baseUrlForImages}$postImage',
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress == null)
                  {
                    return child;
                  }
                  else{
                    return Center(
                      child: SizedBox(
                          width: 25.w,
                          height: 25.w,
                          child: CircularProgressIndicator(
                            value: loadingProgress.cumulativeBytesLoaded.toDouble() / loadingProgress.expectedTotalBytes!.toDouble(),
                          )
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) =>
                    Center(
                      child: MyText(
                        text: 'Try again later',
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              ),
          )
        ),
        ExpandableText(
          caption?? '',
          style: TextStyle(fontSize: 16.sp,color: Colors.black),
          linkTextStyle: const TextStyle(color: Colors.blue),
          trimType: TrimType.lines,
          trim: 2,
          readMoreText: 'show more',
          readLessText: 'show less',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async
              {
                context.normalNewRoute(
                  PostComments(
                    postId: id!,
                    currentUserId: currentUserId,
                    postManagerId: postManagerId,
                    userImageUrl: userImageUrl,
                    userName: userName,
                    postImage: postImage,
                    caption: caption!,
                    commentsNumber: commentsNumber,
                    time: time,
                  ),
                );
              },
              icon: const Icon(Icons.mode_comment_outlined,color: Colors.grey,),
            ),
            MyText(text: '$commentsNumber',color: Colors.grey,),
          ],
        )
      ],
    );
  }
}
