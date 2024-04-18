import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/model/local/flutter_secure_storage.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/modules/app_widgets/comments_model.dart';
import 'package:gardenia/modules/base_widgets/divider.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/view/create_post/create_post.dart';
import 'package:gardenia/modules/app_widgets/post_model.dart';
import 'package:gardenia/view/home/post_comments.dart';
import 'package:gardenia/view/home/shimmer_comments_effect.dart';
import 'package:gardenia/view/home/shimmer_posts_effect.dart';
import 'package:gardenia/view_model/create_post/cubit.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:gardenia/view_model/home/states.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  late HomeCubit homeCubit;

  @override
  void initState() {
    homeCubit = HomeCubit.getInstance(context);
    homeCubit.getPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: MyText(text: 'Posts',fontSize: 28.sp,fontWeight: FontWeight.bold,color: Constants.appColor,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeCubit,HomeStates>(
          builder: (context, state) => state is GetPostsLoadingState?
          const ShimmerEffect():
          ListView(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child:
                    CircleAvatar(
                        backgroundImage: const NetworkImage('WcDWUpFLuFQCjHSdv7uu7xhbXC3g0uAA.png'),
                        radius: 20.sp,
                      ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: ()
                      {
                        context.normalNewRoute(CreatePost());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border(
                            left: BorderSide(color: Constants.appColor),
                            bottom: BorderSide(color: Constants.appColor),
                            top: BorderSide(color: Constants.appColor),
                            right: BorderSide(color: Constants.appColor),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: MyText(
                            text: 'What’s on your mind?',
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.image,color: Constants.appColor,))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0.h),
                child: Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                        width: context.setWidth(1.5),
                        child: const MyDivider(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Post(
                      currentUserId: CacheHelper.getInstance().sharedPreferences.getStringList('userData')![0].toInt(),
                      postManagerId: homeCubit.posts[index].userId,
                      userImageUrl: homeCubit.posts[index].userImage,
                      userName: homeCubit.posts[index].userName ,
                      postImage: homeCubit.posts[index].image?? '',
                      caption: homeCubit.posts[index].caption?? '',
                      commentsNumber: homeCubit.posts[index].commentsCount,
                      time: homeCubit.posts[index].creationTime.substring(0,10),
                      onPressed: () async
                      {
                        context.normalNewRoute(
                            PostComments(
                              postId: homeCubit.posts[index].postId,
                              currentUserId: CacheHelper.getInstance().sharedPreferences.getStringList('userData')![0].toInt(),
                              postManagerId: homeCubit.posts[index].userId,
                              userImageUrl: homeCubit.posts[index].userImage,
                              userName: homeCubit.posts[index].userName,
                              postImage: homeCubit.posts[index].image,
                              caption: homeCubit.posts[index].caption!,
                              commentsNumber: homeCubit.posts[index].commentsCount,
                              time: homeCubit.posts[index].creationTime,
                        ),
                        );
                        // scaffoldKey.currentState!.showBottomSheet((context) => BlocBuilder<HomeCubit,HomeStates>(
                        //   builder: (context, state) => Container(
                        //       width: double.infinity,
                        //       height: context.setHeight(1.4),
                        //       decoration: const BoxDecoration(
                        //           borderRadius: BorderRadius.vertical(top: Radius.circular(16))
                        //       ),
                        //       child:
                        //       state is GetCommentsLoading?
                        //       const ShimmerCommentsEffect():
                        //       Stack(
                        //         children: [
                        //           ListView(
                        //             children: [
                        //               Padding(
                        //                 padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 32.h),
                        //                 child: Row(
                        //                   mainAxisAlignment: MainAxisAlignment.start,
                        //                   children: [
                        //                     MyText(
                        //                       text: 'Comments (${homeCubit.posts[index].commentsCount})',
                        //                       fontSize: 16.sp,
                        //                       fontWeight: FontWeight.w500,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Expanded(
                        //                 child: ListView.separated(
                        //                   shrinkWrap: true,
                        //                   physics: const NeverScrollableScrollPhysics(),
                        //                   itemBuilder: (context, index) => CommentsModel(
                        //                     userImage: homeCubit.comments[index].userImageUrl,
                        //                     userName: homeCubit.comments[index].userName,
                        //                     comment: homeCubit.comments[index].comment,
                        //                     time: homeCubit.comments[index].time,
                        //                     commentManagerId: homeCubit.comments[index].userId,
                        //                     currentUserId: CacheHelper.getInstance().sharedPreferences.getStringList('userData')![0].toInt(),
                        //                     onDelete: () {},
                        //                   ),
                        //                   separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                        //                   itemCount: homeCubit.comments.length,
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height: context.setHeight(9),
                        //               ),
                        //             ],
                        //           ),
                        //           Align(
                        //             alignment: Alignment.bottomCenter,
                        //             child: Container(
                        //               color: Constants.appColor,
                        //               width: double.infinity,
                        //               height: context.setHeight(9),
                        //               child: Center(
                        //                 child: Container(
                        //                   width: context.setWidth(1.1),
                        //                   height: 45.h,
                        //                   clipBehavior: Clip.antiAliasWithSaveLayer,
                        //                   decoration: BoxDecoration(
                        //                       color: Colors.white,
                        //                       borderRadius: BorderRadius.circular(30)
                        //                   ),
                        //                   child: TFF(
                        //                     obscureText: false,
                        //                     controller: commentCont,
                        //                     border: OutlineInputBorder(
                        //                       borderRadius: BorderRadius.circular(30),
                        //                     ),
                        //                     hintText: 'Type your comment here...',
                        //                     hintStyle: TextStyle(
                        //                         color: Constants.appColor,
                        //                         fontSize: 16.sp,
                        //                         fontWeight: FontWeight.w400),
                        //                     suffixIcon: IconButton(
                        //                       onPressed: () async
                        //                       {
                        //                         await homeCubit.createComment(
                        //                             context,
                        //                             postId: homeCubit.posts[index].postId,
                        //                             comment: commentCont.text
                        //                         );
                        //                       },
                        //                       icon: CircleAvatar(
                        //                         backgroundColor: Constants.appColor,
                        //                         child: const Padding(
                        //                           padding: EdgeInsets.all(8.0),
                        //                           child: Icon(Icons.send,color: Colors.white,size: 18,),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //   ),
                        // ),
                        //
                        // );
                        //
                        // await homeCubit.showComments(
                        //     context,
                        //     postId: homeCubit.posts[index].postId
                        // );
                      },
                      onSave: ()
                      {
                        // homeCubit.addToFavorites(
                        //   homeCubit.fakePosts[index],
                        // );
                      },
                      onDelete: () async
                      {
                        await homeCubit.deletePost(
                            context,
                            postId: homeCubit.posts[index].postId,
                        );
                      },
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                itemCount: homeCubit.posts.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}