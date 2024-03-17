import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/divider.dart';
import 'package:gardenia/modules/myText.dart';
import 'package:gardenia/view/home/post_model.dart';
import 'package:gardenia/view_model/home/cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    HomeCubit.getInstance(context).getAllPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Posts',fontSize: 28.sp,fontWeight: FontWeight.bold,color: Constants.appColor,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CircleAvatar(
                    backgroundImage: const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIVa0RNjFqKEdcXG0trW_AYrevZXZfNh0VQg&usqp=CAU'),
                    radius: 20.sp,
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
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
                    width: MediaQuery.of(context).size.width/1.5,
                      child: const MyDivider()),
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
                      userImageUrl: HomeCubit.getInstance(context).posts[index].userImageUrl,
                      userName: HomeCubit.getInstance(context).posts[index].userName,
                      postImage: HomeCubit.getInstance(context).posts[index].postImage,
                      caption: HomeCubit.getInstance(context).posts[index].postCaption,
                      commentsNumber: HomeCubit.getInstance(context).posts[index].commentsNumber,
                      onPressed: () {},
                      onSave: ()
                      {
                        HomeCubit.getInstance(context).addToFavorites(
                            HomeCubit.getInstance(context).posts[index],
                        );
                      },
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                itemCount: HomeCubit.getInstance(context).posts.length,
            )
          ],
        ),
      ),
    );
  }
}
