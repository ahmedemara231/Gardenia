import 'package:flutter/src/widgets/framework.dart';
import 'package:gardenia/view_model/profile/cubit.dart';
import '../../../view_model/home/cubit.dart';
import 'interface.dart';

class HomeHandling extends HandleUpdatePost
{
  @override
  Future<void> handleEditProcess(BuildContext context, {
        required int index,
        required String newCaption,
  })async{
    HomeCubit.getInstance(context).editPost(
        index: index,
        context,
        postId: HomeCubit.getInstance(context).posts[index].postId!,
        newCaption: newCaption
    );
  }

  @override
  Future<void> handleDeleteProcess(
      BuildContext context, {
        required int postId
      })async {
    HomeCubit.getInstance(context).deletePost(context, postId: postId);
  }


  @override
  Future<void> handleSaveImageToGallery(BuildContext context, String imageUrl) async{
    await HomeCubit.getInstance(context).handleSavingPostImage(imageUrl);
  }
}

class ProfileHandling extends HandleUpdatePost
{
  @override
  Future<void> handleEditProcess(BuildContext context, {
    required int index,
    required String newCaption,
  })async{
    ProfileCubit.getInstance(context).editUserPosts(
        context,
        postId: ProfileCubit.getInstance(context).userPosts[index].postId!,
        index: index,
        newCaption: newCaption,
    );
  }

  @override
  Future<void> handleDeleteProcess(
      BuildContext context, {
        required int postId
      })async {
    ProfileCubit.getInstance(context).deletePost(context, postId: postId);
    await HomeCubit.getInstance(context).deletePost(context, postId: postId);
  }

  @override
  Future<void> handleSaveImageToGallery(BuildContext context, String imageUrl) async{
    await ProfileCubit.getInstance(context).handleSavingPostImage(imageUrl);
  }
}