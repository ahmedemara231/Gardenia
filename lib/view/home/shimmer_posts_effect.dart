import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/modules/app_widgets/post_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/constants.dart';
import '../../modules/base_widgets/divider.dart';
import '../../modules/base_widgets/myText.dart';
import '../../view_model/home/cubit.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      period: const Duration(seconds: 2),
      child: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: CircleAvatar(
                  radius: 20.sp,
                ),
              ),
              Expanded(
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
              const Icon(Icons.image)
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0.h),
            child: Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.5,
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
                  currentUserId: 0,
                  postManagerId: 0,
                  userImageUrl: HomeCubit.getInstance(context).fakePosts[index].userImageUrl,
                  userName: HomeCubit.getInstance(context).fakePosts[index].userName ,
                  postImage: HomeCubit.getInstance(context).fakePosts[index].postImage,
                  caption: HomeCubit.getInstance(context).fakePosts[index].postCaption,
                  commentsNumber: HomeCubit.getInstance(context).fakePosts[index].commentsNumber,
                  time: '',
                  onPressed: () {},
                  onSave: () {},
                  onDelete: () {},
                )
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(height: 25.h,),
            itemCount: HomeCubit.getInstance(context).fakePosts.length,
          )
        ],
      ),
    );
  }
}
