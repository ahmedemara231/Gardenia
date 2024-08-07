import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/string.dart';
import 'package:gardenia/model/local/Hive/registers.dart';
import 'package:gardenia/model/local/secure_storage.dart';
import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/model/remote/api_service/repositories/delete_repo.dart';
import 'package:gardenia/model/remote/api_service/repositories/get_repo.dart';
import 'package:gardenia/model/remote/api_service/repositories/post_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/request_models/download_request_model.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/modules/data_types/comment.dart';
import 'package:gardenia/modules/data_types/permission_process.dart';
import 'package:gardenia/modules/data_types/post.dart';
import 'package:gardenia/modules/data_types/fake_posts_data.dart';
import 'package:gardenia/modules/methods/check_permission.dart';
import 'package:gardenia/view_model/home/states.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../model/remote/api_service/repositories/put_patch_repo.dart';
import '../../modules/methods/save_image_to_gellary.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  factory HomeCubit.getInstance(context) => BlocProvider.of(context);

  Future<String?> get userToken async
  {
    String? token = await SecureStorage.getInstance().readData(
        key: 'userToken');
    return token;
  }

  List<FakePostData> fakePosts =
  [
    FakePostData(
        userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKXYSs2F_0O04sLv8AjIH43Owr2rEIfkFEOA&usqp=CAU',
        userName: 'Ahmed Emara',
        postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKXYSs2F_0O04sLv8AjIH43Owr2rEIfkFEOA&usqp=CAU',
        postCaption: 'Hello to everyone',
        commentsNumber: 15),
    FakePostData(
        userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqQMwq_mZ2I9qpXPhmIeJ5on2jZTavrF65Kw&usqp=CAU',
        userName: 'abdallah saad',
        postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqQMwq_mZ2I9qpXPhmIeJ5on2jZTavrF65Kw&usqp=CAU',
        postCaption: 'Hello Gyes',
        commentsNumber: 50),
    FakePostData(
        userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOk_Z2l6Qsdg6BO3fhHSJZs1O3Wv4QQknng&usqp=CAU',
        userName: 'Shrouk',
        postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOk_Z2l6Qsdg6BO3fhHSJZs1O3Wv4QQknng&usqp=CAU',
        postCaption: 'Hello everybody',
        commentsNumber: 20),
    FakePostData(
        userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-eF2EPE0vA6B9cNIfTX_lnizV3OGwTdADaA&usqp=CAU',
        userName: 'Rewan Elmallah',
        postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-eF2EPE0vA6B9cNIfTX_lnizV3OGwTdADaA&usqp=CAU',
        postCaption: 'Welcome',
        commentsNumber: 10),
    FakePostData(
        userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlCovEjfkoAOO2lBxcLc1X9bakoJryadHWOQ&usqp=CAU',
        userName: 'Rahaf',
        postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlCovEjfkoAOO2lBxcLc1X9bakoJryadHWOQ&usqp=CAU',
        postCaption: 'Welcome Guyes',
        commentsNumber: 30),
  ];

  List<PostData2> favorites = [];

  GetRepo getRepo = GetRepo(apiService: DioConnection.getInstance());

  List<PostData2> posts = [];

  Future<void> getPosts() async
  {
    emit(GetPostsLoadingState());

    await getRepo.getPosts().then((result) {
      if (result.isSuccess()) {
        posts = result.getOrThrow();

        HiveRegisters.getInstance().getPostsBox.addAll(posts);

        emit(GetPostsSuccessState());
      }
      else {
        log('error is ${result.tryGetError()}');
        if (result.tryGetError() is NetworkError) {
          emit(
              GetPostsNetworkErrorState(
                message: result.tryGetError()!.message!,
              )
          );
        }
        else {
          emit(GetPostsErrorState());
        }
      }
    });
  }

  Future<void> handleStoragePermission(context,
      {required String postImage}) async
  {
    await checkPermission(
      PermissionProcessModel(
        permissionClient: PermissionClient.storage,
        onPermissionGranted: () => downloadPostImage(postImage),
        onPermissionDenied: () => Navigator.pop(context),
      ),
    );
  }

  Future<String> getPathToSaveImage(String imageLastSegment) async
  {
    final directory = await getApplicationDocumentsDirectory();
    String fileName = imageLastSegment;
    final imagePath = directory.path + fileName;
    return imagePath;
  }

  Future<void> downloadPostImage(String postImage) async
  {
    log('loading');
    getRepo.downloadPostImage(
      DownloadModel(
        urlPath: '${ApiConstants.baseUrlForImages}$postImage',
        savePath: await getPathToSaveImage(postImage
            .split('/')
            .last),
        onReceiveProgress: (received, total) {},
      ),
    ).then((result) {
      if (result.isSuccess()) {
        log('downloaded');
      }
      else {
        log('error');
      }
    });
    // FileInfo file = await DefaultCacheManager().downloadFile(url);
    // log('${file.validTill}');
  }

  RoundedLoadingButtonController editPostBtnCont = RoundedLoadingButtonController();
  PutRepo updateRepo = PutRepo(apiService: DioConnection.getInstance());

  Future<void> editPost(BuildContext context, {
    required int postId,
    required int index,
    required String newCaption,
  }) async
  {
    await updateRepo.editPost(
      postId: postId,
      newCaption: newCaption,
    ).then((result) async
    {
      emit(EditPostLoadingState());

      if (result.isSuccess()) {
        editPostBtnCont.success();
        await Future.delayed(
          const Duration(milliseconds: 1500),
              () {
            posts[index].caption = newCaption;
            Navigator.pop(context);
          },
        );
        emit(EditPostSuccessState());
      }
      else {
        editPostBtnCont.reset();
        emit(EditPostErrorState());
      }
    });
  }

  DeleteRepo deleteRepo = DeleteRepo(apiService: DioConnection.getInstance());

  Future<void> deletePost(context, {required int postId}) async
  {
    await deleteRepo.deletePost(postId).then((result) {
      if (result.isSuccess()) {
        MyToast.showToast(
            context,
            msg: result.tryGetSuccess()!.message,
            color: Constants.appColor
        );
        posts.removeWhere((element) => element.postId == postId);
        emit(DeletePostSuccess());
      }
      else {
        emit(DeletePostError());
      }
    });
  }

  PostRepo postRepo = PostRepo(apiService: DioConnection.getInstance());

  Future<void> createComment(context,
      {required int postId, required String comment}) async
  {
    emit(CreateCommentLoading());
    await postRepo.createComment(postId: postId, comment: comment).then((
        result) async
    {
      if (result.isSuccess()) {
        comments.add(
          Comment(
            userId: CacheHelper.getInstance().getUserData()![0].toInt(),
            userName: CacheHelper.getInstance().getUserData()![1],
            userImageUrl: CacheHelper.getInstance().getUserData()![3],
            comment: result
                .getOrThrow()
                .data?['content'],
            time: result
                .getOrThrow()
                .data?['created_at'],
            id: result
                .getOrThrow()
                .data?['id'],
          ),
        );
        emit(CreateCommentSuccess());
        MyToast.showToast(
          context,
          msg: result
              .getOrThrow()
              .message,
        );
      }
      else {
        if (result.tryGetError() is NetworkError) {
          MyToast.showToast(
            context,
            msg: 'Check your internet connection and try again',
          );
        }
        emit(CreateCommentError());
      }
    });
  }

  List<Comment> comments = [];

  Future<void> showComments(context, {required int postId}) async
  {
    emit(GetCommentsLoading());
    await getRepo.getCommentsForPost(postId).then((result) {
      if (result.isSuccess()) {
        comments = result.getOrThrow();

        emit(GetCommentsSuccess());
      }
      else {
        if (result.tryGetError() is NetworkError) {
          MyToast.showToast(
              context,
              msg: 'Check your internet connection and try again',
              color: Colors.red
          );
        }
        emit(GetCommentsError());
      }
    });
  }

  Future<void> deleteComment({
    required int postId,
    required int commentId,
  }) async
  {
    await deleteRepo.deleteComment(
        postId: postId,
        commentId: commentId
    ).then((result) {
      if (result.isSuccess()) {
        comments.removeWhere((element) => element.id == commentId);
        emit(DeleteCommentSuccess());
      }
      else {
        emit(DeleteCommentError());
      }
    });
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
}
