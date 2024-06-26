import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/extensions/context.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/modules/data_types/post.dart';
import 'package:gardenia/view/post_operations/update_delete_methods/interface.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../constants/constants.dart';
import '../../../model/remote/api_service/service/constants.dart';
import '../../../modules/base_widgets/myText.dart';

class UpdatePost extends StatefulWidget {

  final PostData2 postData;
  final int index;
  final HandleUpdatePost handleUpdatePost;

  const UpdatePost({super.key,
    required this.index,
    required this.postData,
    required this.handleUpdatePost,
  });

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {

  final editCaptionCont = TextEditingController();
  @override
  void initState() {
    editCaptionCont.text = widget.postData.caption!;
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
                    widget.postData.userImage == null || widget.postData.userImage!.isEmpty?
                    Constants.defaultProfileImage :
                    '${ApiConstants.baseUrlForImages}${widget.postData.userImage}'
                ),
                radius: 22.sp,
              ),
              title:  MyText(
                text: widget.postData.userName!,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              subtitle: MyText(text: widget.postData.creationTime.substring(0,10)),
            ),
            SizedBox(
                width: context.setWidth(1.1),
                child: Image.network('${ApiConstants.baseUrlForImages}${widget.postData.image}')
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
                onPressed: editCaptionCont.text == widget.postData.caption?
                null: ()
                {
                  widget.handleUpdatePost.handleEditProcess(
                      context,
                      index: widget.index,
                      newCaption: editCaptionCont.text
                  );
                },
                child: MyText(text: 'Save',color: Colors.white,fontSize: 18.sp,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
