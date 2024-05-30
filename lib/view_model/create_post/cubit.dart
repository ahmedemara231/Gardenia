import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/modules/data_types/permission_process.dart';
import 'package:gardenia/modules/methods/check_permission.dart';
import 'package:gardenia/view/bottomNavBar/bottom_nav_bar.dart';
import 'package:gardenia/view_model/create_post/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../model/remote/api_service/repositories/post_repo.dart';
import '../../model/remote/api_service/service/connections/dio_connection.dart';
import '../../modules/base_widgets/toast.dart';

class CreatePostCubit extends Cubit<CreatePostStates>
{
  CreatePostCubit() : super(CreatePostInitialState());
  factory CreatePostCubit.getInstance(context) => BlocProvider.of(context);

  late Permission permission;

  Future<void> handleImagePicking(context,{required ImageSource source})async
  {
    await checkPermission(
        PermissionProcessModel(
          permissionClient: PermissionClient.camera,
          onPermissionGranted: () => pickImage(source: source),
          onPermissionDenied: () {
            Navigator.pop(context);
            MyToast.showToast(
              context,
              msg: 'Enable Camera to can post',
              color: Colors.red
            );
          },
        )
    );
  }

  final ImagePicker picker = ImagePicker();
  XFile? image;
  File? selectedImage;
  Future<void> pickImage({required ImageSource source})async
  {
    image = await picker.pickImage(source: source);
    if(image == null)
      {
        emit(CancelSelectingImageState());
        return;
      }
    else{
      selectedImage = File(image!.path);
      emit(SelectImageSuccessState());
    }
  }

  final createPostCont = RoundedLoadingButtonController();
  PostRepo postRepo = PostRepo(apiService: DioConnection.getInstance());

  double percent = 0;
  Future<void> createPost(
      BuildContext context, {
    required String caption,
})async
  {
    emit(CreatePostLoadingState());

    await postRepo.createPost(
      caption: caption,
      selectedImage: selectedImage!,
      onSendProgress: (count, total)
      {
        percent = count / total;
        emit(PercentIncrementState());
      },
    ).then((result)async
    {
      if(result.isSuccess())
        {
          createPostCont.success();
          await Future.delayed(
            const Duration(milliseconds: 1500),
                () {
              context.removeOldRoute(const BottomNavBar());
              selectedImage = null;
            },
          );
          emit(CreatePostSuccessState());
        }
      else{
        emit(CreatePostErrorState());
      }
    });
  }

}