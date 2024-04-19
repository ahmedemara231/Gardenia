import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/modules/data_types/post.dart';
import 'package:gardenia/view/home/home.dart';
import 'package:gardenia/view_model/create_post/states.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../model/remote/api_service/repositories/post_repo.dart';
import '../../model/remote/api_service/service/dio_connection.dart';

class CreatePostCubit extends Cubit<CreatePostStates>
{
  CreatePostCubit() : super(CreatePostInitialState());
  factory CreatePostCubit.getInstance(context) => BlocProvider.of(context);

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
          HomeCubit.getInstance(context).addPost(
              Post(
                  postId: result.getOrThrow().data?['id'],
                  caption: result.getOrThrow().data?['caption'],
                  image: result.getOrThrow().data?['image'],
                  commentsCount: 0,
                  creationTime:result.getOrThrow().data? ['created_at'],
                  userId: (await CacheHelper.getInstance().getData('userData') as List<String>)[0].toInt(),
                  userName: (await CacheHelper.getInstance().getData('userData') as List<String>)[1],
                  userImage: Constants.defaultProfileImage
              ),
          );
          await Future.delayed(
            const Duration(milliseconds: 1500),
                () {
              Navigator.pop(context);
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