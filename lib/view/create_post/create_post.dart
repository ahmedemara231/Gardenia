import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/service/dio_connection.dart';
import 'package:gardenia/modules/app_widgets/arrow_back_button.dart';
import 'package:gardenia/modules/base_widgets/divider.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/view_model/create_post/cubit.dart';
import 'package:gardenia/view_model/create_post/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});

  final postCaptionCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
        title: MyText(
          text: 'Create post',
          color: Constants.appColor,
          fontSize: 22.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 12.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                child: BlocBuilder<CreatePostCubit,CreatePostStates>(
                  buildWhen: (previous, current) => current is PercentIncrementState,
                  builder: (context, state) =>
                  state is CreatePostLoadingState ||
                  state is PercentIncrementState ?
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                            value: CreatePostCubit.getInstance(context).percent
                        ),
                      ),
                      SizedBox(width: 10.w),
                      MyText(
                        text: '${CreatePostCubit.getInstance(context).percent*100} %',
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ):
                  const SizedBox(),
                ),
              ),

              Row(
                children: [
                  // CircleAvatar(
                  //   radius: 25,
                  //   backgroundImage: NetworkImage(''),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: MyText(
                      text: CacheHelper.getInstance().sharedPreferences.getStringList('userData')![1],
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                child: TFF(
                  obscureText: false,
                  controller: postCaptionCont,
                  hintText: 'What’s on your mind, Sam?',
                ),
              ),
              BlocBuilder<CreatePostCubit,CreatePostStates>(
                buildWhen: (previous, current) => current is SelectImageSuccessState,
                builder: (context, state) => Container(
                  width: context.setWidth(1),
                  height: context.setWidth(1),
                  color: Colors.grey[300],
                  child: CreatePostCubit.getInstance(context).selectedImage != null?
                  Stack(
                    children: [
                      Image.file(
                        CreatePostCubit.getInstance(context).selectedImage!,
                        fit: BoxFit.fill,
                      ),
                      IconButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder())
                        ),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ):
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Constants.appColor,
                        child: IconButton(
                          onPressed: ()async
                          {
                            await CreatePostCubit.getInstance(context).pickImage(
                                source: ImageSource.camera
                            );
                            // CreatePostCubit.getInstance(context).pickFile();

                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyText(text: 'Drag photo',fontSize: 14.sp,color: Constants.appColor,),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: context.setHeight(10),
              ),
              RoundedLoadingButton(
                  controller: CreatePostCubit.getInstance(context).createPostCont,
                  color: Constants.appColor,
                  borderRadius: 10,
                  width: context.setWidth(1),
                  onPressed: () async {
                    // context.read<CreatePostCubit>().selectedImage;

                    if(CreatePostCubit.getInstance(context).selectedImage == null)
                      {
                        CreatePostCubit.getInstance(context).createPostCont.reset();
                        MyToast.showToast(context, msg: 'Please choose photo',color: Colors.red);
                      }
                    else if(postCaptionCont.text.isEmpty){
                      CreatePostCubit.getInstance(context).createPostCont.reset();
                      MyToast.showToast(context, msg: 'Please write caption',color: Colors.red);
                    }
                    else{
                      await CreatePostCubit.getInstance(context).createPost(
                        context,
                        caption: postCaptionCont.text,
                      );
                    }
                  },
                  child: MyText(text: 'Post',color: Colors.white,fontSize: 18.sp,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
