import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/modules/base_widgets/divider.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/view/create_post/create_post.dart';
import 'package:gardenia/modules/app_widgets/post_model.dart';
import 'package:gardenia/view/home/shimmer_posts_effect.dart';
import 'package:gardenia/view/home/update_post/update_post.dart';
import 'package:gardenia/view/profile/profile.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:gardenia/view_model/home/states.dart';
import 'package:page_transition/page_transition.dart';
import '../../modules/app_widgets/app_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
      appBar: AppBar(
        centerTitle: true,
        title: MyText(
          text: 'Posts',fontSize: 25.sp,
          color: Constants.appColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeCubit,HomeStates>(
            builder: (context, state)
            {
              if(state is GetPostsLoadingState)
              {
                return const ShimmerEffect();
              }
              else{
                if(state is GetPostsNetworkErrorState)
                {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: MyText(text: state.message),
                        ),
                        AppButton(
                          onPressed: () => homeCubit.getPosts(),
                          text: 'try again',
                          width: 5,
                        ),
                      ],
                    ),
                  );
                }
                else{
                  return RefreshIndicator(
                    onRefresh: () => homeCubit.getPosts(),
                    color: Constants.appColor,
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child:
                              InkWell(
                                onTap: () => context.normalNewRoute(const Profile()),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('${ApiConstants.baseUrlForImages}${CacheHelper.getInstance().getUserData()![3]}'),
                                  radius: 20.sp,
                                ),
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
                                id: homeCubit.posts[index].postId,
                                currentUserId: CacheHelper.getInstance().getUserData()![0].toInt(),
                                postManagerId: homeCubit.posts[index].userId,
                                userImageUrl: homeCubit.posts[index].userImage,
                                userName: homeCubit.posts[index].userName ,
                                postImage: homeCubit.posts[index].image,
                                caption: homeCubit.posts[index].caption,
                                commentsNumber: homeCubit.posts[index].commentsCount,
                                time: homeCubit.posts[index].creationTime.substring(0,10),
                                onEditClick: () =>
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: UpdatePost(index: index),
                                        ),
                                    ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                          itemCount: homeCubit.posts.length,
                        )
                      ],
                    ),
                  );
                }
              }
            }
        )
      ),
    );
  }
}