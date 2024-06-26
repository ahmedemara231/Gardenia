import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/app_widgets/post_model.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/data_types/post.dart';
import 'package:gardenia/view/settting/setting.dart';
import 'package:gardenia/view_model/profile/cubit.dart';
import 'package:gardenia/view_model/profile/states.dart';
import '../post_operations/update_delete_methods/implementation.dart';
import '../post_operations/update_home_post.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    ProfileCubit.getInstance(context).getProfileData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileStates>(
      builder: (context, state) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const ArrowBackButton(),
          title: MyText(
            text: 'Profile',
            color: Constants.appColor,fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          centerTitle: true,
          actions:
          [
            IconButton(
                onPressed: () {context.normalNewRoute(const Setting());},

                icon: Icon(Icons.tune_sharp,color: Constants.appColor,),
            )
          ],
        ),
        body: state is GetProfileLoading?
        const Center(
          child: CircularProgressIndicator()
        ) :
        RefreshIndicator(
          onRefresh: () =>  ProfileCubit.getInstance(context).getProfileData(),
          color: Constants.appColor,
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: context.setHeight(2.5),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 70.h),
                        child: Image.asset(
                          Constants.profileBackgroundImage,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius : 50.sp,
                        backgroundImage: NetworkImage(
                            '${ApiConstants.baseUrlForImages}${ProfileCubit.getInstance(context).profileData.data?['image']}'
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        child: MyText(
                            text: ProfileCubit.getInstance(context).profileData.data?['username'],
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Constants.appColor
                        ),
                      ),
                    ],
                  ),
                ],
              ),


              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 20..w
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Post(
                      id: ProfileCubit.getInstance(context).userPosts[index].postId,
                      currentUserId: CacheHelper.getInstance().getUserData()![0].toInt(),
                      postManagerId: CacheHelper.getInstance().getUserData()![0].toInt(),
                      userImageUrl: ProfileCubit.getInstance(context).profileData.data?['image'],
                      userName: ProfileCubit.getInstance(context).profileData.data?['username'],
                      postImage: ProfileCubit.getInstance(context).userPosts[index].image,
                      caption: ProfileCubit.getInstance(context).userPosts[index].caption,
                      time: ProfileCubit.getInstance(context).userPosts[index].creationTime.substring(0,10),
                      commentsNumber: 0,
                      onEditClick: () => context.normalNewRoute(
                        UpdatePost(
                          index: index,
                          postData: PostData2(
                              commentsCount: null,
                              postId: null,
                              userId: null,
                              caption: ProfileCubit.getInstance(context).userPosts[index].caption,
                              image: ProfileCubit.getInstance(context).userPosts[index].image,
                              creationTime: ProfileCubit.getInstance(context).userPosts[index].creationTime.substring(0,10),
                              userName: ProfileCubit.getInstance(context).profileData.data?['username'],
                              userImage: ProfileCubit.getInstance(context).profileData.data?['image']
                          ),
                          handleUpdatePost: ProfileHandling(),
                        ),
                      ),
                      handling: ProfileHandling(),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                    itemCount: ProfileCubit.getInstance(context).userPosts.length
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
