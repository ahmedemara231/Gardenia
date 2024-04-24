import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../constants/constants.dart';
import '../../../model/remote/api_service/service/constants.dart';
import '../../../modules/base_widgets/myText.dart';

class UpdatePost extends StatefulWidget {
  final int index;
  const UpdatePost({super.key,
    required this.index,
  });

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {

  final editCaptionCont = TextEditingController();
  @override
  void initState() {
    editCaptionCont.text = HomeCubit.getInstance(context).posts[widget.index].caption!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    HomeCubit.getInstance(context).posts[widget.index].userImage == null || HomeCubit.getInstance(context).posts[widget.index].userImage!.isEmpty?
                    Constants.defaultProfileImage :
                    '${ApiConstants.baseUrlForImages}${HomeCubit.getInstance(context).posts[widget.index].userImage}'
                ),
                radius: 22.sp,
              ),
              title:  MyText(text: HomeCubit.getInstance(context).posts[widget.index].userName,fontSize: 16.sp,fontWeight: FontWeight.bold,),
              subtitle: MyText(text: HomeCubit.getInstance(context).posts[widget.index].creationTime.substring(0,10)),
            ),
            SizedBox(
                width: context.setWidth(1.1),
                child: Image.network('${ApiConstants.baseUrlForImages}${HomeCubit.getInstance(context).posts[widget.index].image!}')
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: TFF(
                obscureText: false,
                controller: editCaptionCont,
                onChanged: (newLetter) {setState(() {});},
                suffixIcon: const Icon(Icons.edit_sharp),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: RoundedLoadingButton(
                controller: HomeCubit.getInstance(context).editPostBtnCont,
                color: Constants.appColor,
                borderRadius: 10,
                width: context.setWidth(1),
                onPressed: editCaptionCont.text == HomeCubit.getInstance(context).posts[widget.index].caption?
                null: () async {
                  HomeCubit.getInstance(context).editPost(
                    index: widget.index,
                    context,
                    postId: HomeCubit.getInstance(context).posts[widget.index].postId,
                    newCaption: editCaptionCont.text,
                  );
                },
                child: MyText(text: 'Save',color: Colors.white,fontSize: 18.sp,),
              ),
            ),
            // Post(
            //   id: HomeCubit.getInstance(context).posts[widget.index].postId,
            //   currentUserId: CacheHelper.getInstance().getUserData()![0].toInt(),
            //   postManagerId: HomeCubit.getInstance(context).posts[widget.index].userId,
            //   userImageUrl: HomeCubit.getInstance(context).posts[widget.index].userImage,
            //   userName: HomeCubit.getInstance(context).posts[widget.index].userName,
            //   postImage: HomeCubit.getInstance(context).posts[widget.index].image,
            //   caption: HomeCubit.getInstance(context).posts[widget.index].caption,
            //   commentsNumber: HomeCubit.getInstance(context).posts[widget.index].commentsCount,
            //   time: HomeCubit.getInstance(context).posts[widget.index].creationTime.substring(0,10),
            // ),
          ],
        ),
      ),
    );
  }
}
