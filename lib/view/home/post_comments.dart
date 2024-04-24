import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/modules/app_widgets/post_model.dart';
import 'package:gardenia/view/home/shimmer_comments_effect.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:gardenia/view_model/home/states.dart';
import '../../constants/constants.dart';
import '../../model/local/shared_prefs.dart';
import '../../modules/app_widgets/comments_model.dart';
import '../../modules/base_widgets/myText.dart';
import '../../modules/base_widgets/textFormField.dart';

class PostComments extends StatefulWidget {
  int postId;
  int currentUserId;
  int postManagerId;
  String? userImageUrl;
  String userName;
  String? caption;
  String? postImage;
  int commentsNumber;
  String time;

  PostComments({super.key,
    required this.currentUserId,
    required this.postManagerId,
    required this.postId,
    required this.userImageUrl,
    required this.userName,
    required this.postImage,
    required this.caption,
    required this.commentsNumber,
    required this.time
  });

  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {

  final scrollCont = ScrollController();

  final commentCont = TextEditingController();

  late HomeCubit homeCubit;

  @override
  void initState() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.showComments(context, postId: widget.postId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Post',fontSize: 28.sp,fontWeight: FontWeight.bold,color: Constants.appColor,),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit,HomeStates>(
        builder: (context, state) =>
        state is GetCommentsLoading?
        const ShimmerCommentsEffect():
        Stack(
          children: [
            ListView(
              controller: scrollCont,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Post(
                      currentUserId: widget.currentUserId,
                      postManagerId: widget.postManagerId,
                      userImageUrl: widget.userImageUrl,
                      userName: widget.userName,
                      postImage: widget.postImage,
                      caption: widget.caption,
                      commentsNumber: homeCubit.comments.length,
                      time: widget.time.substring(0,10),
                  ),
                ),
                Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black,width: 2))
                    ),
                    child:
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 32.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Comments (${homeCubit.comments.length})',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => CommentsModel(
                            userImage: homeCubit.comments[index].userImageUrl,
                            userName: homeCubit.comments[index].userName,
                            comment: homeCubit.comments[index].comment,
                            time: homeCubit.comments[index].time,
                            commentManagerId: homeCubit.comments[index].userId,
                            currentUserId: CacheHelper.getInstance().getUserData()![0].toInt(),
                            onDelete: () async{
                              homeCubit.deleteComment(
                                  postId: widget.postId,
                                  commentId: homeCubit.comments[index].id
                              );
                            },
                          ),
                          separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                          itemCount: homeCubit.comments.length,
                        ),
                      ],
                    ),
                ),
                SizedBox(height: context.setHeight(9)),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Constants.appColor,
                width: double.infinity,
                height: context.setHeight(9),
                child: Center(
                  child: Container(
                    width: context.setWidth(1.1),
                    height: 45.h,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: TFF(
                      obscureText: false,
                      controller: commentCont,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Type your comment here...',
                      hintStyle: TextStyle(
                          color: Constants.appColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400),
                      suffixIcon: IconButton(
                        onPressed: () async
                        {
                          if(commentCont.text.isNotEmpty)
                          {
                            await homeCubit.createComment(
                                context,
                                postId: widget.postId,
                                comment: commentCont.text
                            );
                            commentCont.clear();
                          }
                          else{
                            return;
                          }

                        },
                        icon: CircleAvatar(
                          backgroundColor: Constants.appColor,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: state is CreateCommentLoading?
                              const CircularProgressIndicator():
                              const Icon(Icons.send,color: Colors.white,size: 18,)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}