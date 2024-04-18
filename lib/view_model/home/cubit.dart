import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/mediaQuery.dart';
import 'package:gardenia/model/local/flutter_secure_storage.dart';
import 'package:gardenia/model/remote/api_service/model/model.dart';
import 'package:gardenia/model/remote/api_service/repositories/delete_repo.dart';
import 'package:gardenia/model/remote/api_service/repositories/get_repo.dart';
import 'package:gardenia/model/remote/api_service/repositories/post_repo.dart';
import 'package:gardenia/model/remote/api_service/service/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';
import 'package:gardenia/model/remote/api_service/service/request_model.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/modules/data_types/comment.dart';
import 'package:gardenia/modules/data_types/post.dart';
import 'package:gardenia/modules/data_types/posts_data.dart';
import 'package:gardenia/modules/app_widgets/comments_model.dart';
import 'package:gardenia/view_model/home/states.dart';

class HomeCubit extends Cubit<HomeStates>
{
  HomeCubit() : super(HomeInitialState());
  factory HomeCubit.getInstance(context) => BlocProvider.of(context);

  Future<String?> get userToken async
  {
    String? token = await SecureStorage.getInstance().readData(key: 'userToken');
    return token;
  }

  List<PostData> fakePosts =
  [
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKXYSs2F_0O04sLv8AjIH43Owr2rEIfkFEOA&usqp=CAU', userName: 'Ahmed Emara', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKXYSs2F_0O04sLv8AjIH43Owr2rEIfkFEOA&usqp=CAU', postCaption: 'Hello to everyone', commentsNumber: 15),
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqQMwq_mZ2I9qpXPhmIeJ5on2jZTavrF65Kw&usqp=CAU', userName: 'abdallah saad', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqQMwq_mZ2I9qpXPhmIeJ5on2jZTavrF65Kw&usqp=CAU', postCaption: 'Hello Gyes', commentsNumber: 50),
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOk_Z2l6Qsdg6BO3fhHSJZs1O3Wv4QQknng&usqp=CAU', userName: 'Shrouk', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOk_Z2l6Qsdg6BO3fhHSJZs1O3Wv4QQknng&usqp=CAU', postCaption: 'Hello everybody', commentsNumber: 20),
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-eF2EPE0vA6B9cNIfTX_lnizV3OGwTdADaA&usqp=CAU', userName: 'Rewan Elmallah', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-eF2EPE0vA6B9cNIfTX_lnizV3OGwTdADaA&usqp=CAU', postCaption: 'Welcome', commentsNumber: 10),
    PostData(userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlCovEjfkoAOO2lBxcLc1X9bakoJryadHWOQ&usqp=CAU', userName: 'Rahaf', postImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlCovEjfkoAOO2lBxcLc1X9bakoJryadHWOQ&usqp=CAU', postCaption: 'Welcome Guyes', commentsNumber: 30),
  ];

  List<PostData> favorites = [];
  void addToFavorites(PostData post)
  {
    favorites.add(post);
    print(favorites);
    emit(AddToFavoritesState());
  }

  void removeFromFavorites(PostData post)
  {
    favorites.remove(post);
    print(favorites);
    emit(RemoveFromFavoritesState());
  }

  GetRepo getRepo = GetRepo(apiService: DioConnection.getInstance());

  late Model postsResult;
  List<Post> posts = [];
  Future<void> getPosts()async
  {
    emit(GetPostsLoadingState());

    // final cachedImage = await DefaultCacheManager().getSingleFile('http://Dl2XB8ZYdyrVWUtNm3CRYkfNoEczdBe5.png');
    // print(cachedImage);

    await getRepo.getPosts().then((result)
    {
      if(result.isSuccess())
        {
          postsResult = result.getOrThrow();

          posts = ( postsResult.data!['posts'] as List ).map((e) => Post(
              postId: e['id'],
              caption: e['caption'],
              image: e['image'],
              commentsCount: e['comments_count'],
              creationTime: e['created_at'],
              userId: e['user_id'],
              userName: e['user']['username'],
              userImage: e['user']['image']
          ),).toList();

          // posts.forEach((element) async{
          //   if(element.image != null)
          //     {
          //       final cachedImage = await DefaultCacheManager().getSingleFile('http://${element.image!}');
          //       print(cachedImage);
          //     }
          //   else{
          //     return;
          //   }
          // });

          emit(GetPostsSuccessState());

        }
      else{
        print('error is ${result.tryGetError()}');
        emit(GetPostsErrorState());
      }
    });
  }

  DeleteRepo deleteRepo = DeleteRepo(apiService: DioConnection.getInstance());

  Future<void> deletePost(context,{required int postId})async
  {
    await deleteRepo.deletePost(postId).then((result)
    {
      if(result.isSuccess())
        {
          MyToast.showToast(
              context,
              msg: result.tryGetSuccess()!.message,
              color: Constants.appColor
          );
          posts.removeWhere((element) => element.postId == postId);
          emit(DeletePostSuccess());
        }
      else{
        if(result.tryGetError() is NetworkError)
          {
            MyToast.showToast(
                context,
                msg: 'Check your internet connection and try again',
                color: Colors.red
            );
          }
        emit(DeletePostError());
      }
    });
  }

  PostRepo postRepo = PostRepo(apiService: DioConnection.getInstance());
  Future<void> createComment(context,{required int postId, required String comment})async
  {
    await postRepo.createComment(postId: postId, comment: comment).then((result)
    {
      if(result.isSuccess())
        {
          MyToast.showToast(
            context,
            msg: result.getOrThrow().message,
          );
        }
      else{
        if(result.tryGetError() is NetworkError){
          MyToast.showToast(
            context,
            msg: 'Check your internet connection and try again',
          );
        }
      }
    });
  }

  List<Comment> comments = [];
  Future<void> showComments(context, {required int postId})async
  {
    emit(GetCommentsLoading());
    await getRepo.getCommentsForPost(postId).then((result)
    {
      if(result.isSuccess())
      {
        comments = (result.tryGetSuccess()!.data!['comments'] as List).map((e) =>
            Comment(
              userImageUrl: e['user']['image'],
              userName: e['user']['username'],
              comment: e['content'],
              time: e['created_at'],
              userId: e['user_id']
            ),
        ).toList();

        emit(GetCommentsSuccess());
      }
      else{
        if(result.tryGetError() is NetworkError)
        {
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


}