import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/remote/api_service/model/model.dart';
import 'package:gardenia/model/remote/api_service/repositories/put_patch_repo.dart';
import 'package:gardenia/model/remote/api_service/service/connections/dio_connection.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/view/profile/edit_profile/confirm_image.dart';
import 'package:gardenia/view_model/update_profile/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../modules/methods/image_selector/image_selector.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates>
{
  UpdateProfileCubit() : super(UpdateProfileInitState());
  factory UpdateProfileCubit.getInstance(context) => BlocProvider.of(context);


  File? newProfileImage;
  Future<void> selectNewProfileImage(BuildContext context)async
  {
    ImageSelector imageSelector = ImageSelector();
    await imageSelector.selectImage(ImageSource.gallery).then((selectedImage)
    {
      if(selectedImage == null)
        {
          emit(SelectProfileImageCancel());
          return;
        }
      else{
        newProfileImage = selectedImage;
        context.normalNewRoute(
            const ConfirmImage(),
        );
        emit(SelectProfileImageSuccess());
      }
    });
  }

  final RoundedLoadingButtonController updateImageBtnCont = RoundedLoadingButtonController();
  PutRepo updateRepo = PutRepo(apiService: DioConnection.getInstance());

  late Model updateProfileImageResult;
  Future<void> updateProfileImage(context)async
  {
    emit(UpdateProfileImageLoading());
    await updateRepo.updateProfileImage(newProfileImage!).then((result) async
    {
      if(result.isSuccess())
        {
          updateProfileImageResult = result.getOrThrow();
          updateImageBtnCont.success();
          await Future.delayed(
            const Duration(milliseconds: 1500),
            ()async {
              // await CacheHelper.getInstance().setData(
              //     key: 'userData',
              //     value: [],
              // );
              updateImageBtnCont.reset();
              MyToast.showToast(
                  context,
                  msg: updateProfileImageResult.message,
                  color: Constants.appColor
              );
              Navigator.pop(context);
              emit(UpdateProfileImageSuccess());
            },
          );
        }
      else{
        emit(UpdateProfileImageError());
      }
    });
  }
}