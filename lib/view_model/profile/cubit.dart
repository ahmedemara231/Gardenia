import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/model/model.dart';
import 'package:gardenia/model/remote/api_service/repositories/get_repo.dart';
import 'package:gardenia/model/remote/api_service/repositories/put_patch_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/modules/data_types/update_user_data.dart';
import 'package:gardenia/view_model/home/cubit.dart';
import 'package:gardenia/view_model/profile/states.dart';
import '../../modules/data_types/post.dart';
import '../../modules/methods/save_image_to_gellary.dart';

class ProfileCubit extends Cubit<ProfileStates>
{
  ProfileCubit() : super(ProfileInitState());

  factory ProfileCubit.getInstance(context) => BlocProvider.of(context);

  GetRepo getRepo = GetRepo(apiService: DioConnection.getInstance());

  late Model profileData;
  late List<PostData2> userPosts;

  Future<void> getProfileData()async
  {
    emit(GetProfileLoading());

    await getRepo.getProfileData().then((result)
    {
      if(result.isSuccess())
        {
          profileData = result.getOrThrow();
          userPosts = (profileData.data?['posts'] as List).map((e) => PostData2(
              postId: e['id'],
              caption: e['caption'],
              image: e['image'],
              creationTime: e['created_at'],
              commentsCount: e['comments_count'],
              userId: e['user_id'],
              userName: null,
              userImage: null
          )).toList();


          emit(GetProfileSuccess());
        }
      else{
        if(result.tryGetError() is NetworkError) {}
        emit(GetProfileError());
      }
    });
  }

  Future<void> editUserPosts(context,{
    required int postId,
    required int index,
    required String newCaption
  })async
  {
    userPosts[index].caption = newCaption;
    emit(EditUserPostsSuccess());



   int postIndexInPosts = HomeCubit.getInstance(context).posts.indexOf(userPosts[index]);

    await HomeCubit.getInstance(context).editPost(
        context,
        postId: postId,
        index: postIndexInPosts,
        newCaption: newCaption
    );
  }

  void deletePost(context,{
  required int postId
  })
  {
    userPosts.removeWhere((element) => element.postId == postId);
    emit(DeleteUserPostsSuccess());
  }

  Future<void> handleSavingPostImage(String imageUrl) async {
    await saveImage(imageUrl);
    // checkPermission(
    //   PermissionProcessModel(
    //     permissionClient: PermissionClient.storage,
    //     onPermissionGranted: () => saveImage(imageUrl),
    //     onPermissionDenied: () {},
    //   ),
    // );

  }

  PutRepo putRepo = PutRepo(apiService: DioConnection.getInstance());
  Future<void> editUserData(context,UpdateUserData userData)async
  {
    await putRepo.editUserData(userData).then((result)
    {
      if(result.isSuccess())
        {
          MyToast.showToast(context, msg: 'Updated!',color: Constants.appColor);
          CacheHelper.getInstance().setData(
              key: 'userData',
              value:
              <String>[
                CacheHelper.getInstance().getUserData()![0],
                userData.name,
                userData.email,
                CacheHelper.getInstance().getUserData()?[3]?? Constants.defaultProfileImage
              ],
          );
          emit(EditUserDataSuccess());
        }
      else{
        MyToast.showToast(context, msg: 'Try Again Later',color: Colors.red);
        emit(EditUserDataError());
      }
    });
  }

}
