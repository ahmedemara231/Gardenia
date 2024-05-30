import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/model/remote/api_service/model/model.dart';
import 'package:gardenia/model/remote/api_service/repositories/get_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/model/remote/api_service/service/error_handling/errors.dart';
import 'package:gardenia/modules/data_types/permission_process.dart';
import 'package:gardenia/modules/data_types/user_posts.dart';
import 'package:gardenia/modules/methods/check_permission.dart';
import 'package:gardenia/view_model/profile/states.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileCubit extends Cubit<ProfileStates>
{
  ProfileCubit() : super(ProfileInitState());

  factory ProfileCubit.getInstance(context) => BlocProvider.of(context);

  GetRepo getRepo = GetRepo(apiService: DioConnection.getInstance());

  late Model profileData;
  late List<UserPosts> userPosts;
  Future<void> getProfileData()async
  {
    emit(GetProfileLoading());

    await getRepo.getProfileData().then((result)
    {
      if(result.isSuccess())
        {
          profileData = result.getOrThrow();
          userPosts = (profileData.data?['posts'] as List).map((e) => UserPosts(
              caption: e['caption'], image: e['image'], postId: e['id'],
              creationTime: e['created_at'],
          )).toList();

          emit(GetProfileSuccess());
        }
      else{
        if(result.tryGetError() is NetworkError)
          {

          }
        emit(GetProfileError());
      }
    });
  }
}
