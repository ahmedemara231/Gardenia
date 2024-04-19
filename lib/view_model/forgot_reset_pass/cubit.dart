import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/extensions/routes.dart';
import 'package:gardenia/model/remote/api_service/repositories/post_repo.dart';
import 'package:gardenia/model/remote/api_service/service/dio_connection.dart';
import 'package:gardenia/modules/base_widgets/toast.dart';
import 'package:gardenia/view/auth/otp_code/screen.dart';
import 'package:gardenia/view_model/forgot_reset_pass/states.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotResetPassCubit extends Cubit<ForgotResetPassStates>
{
  ForgotResetPassCubit() : super(ForgotResetPassInitialState());
  factory ForgotResetPassCubit.getInstance(context) => BlocProvider.of(context);


  final RoundedLoadingButtonController forgotPasswordButtonCont = RoundedLoadingButtonController();
  PostRepo postRepo = PostRepo(apiService: DioConnection.getInstance());

  Future<void> forgotPassword(BuildContext context,String email)async{
    emit(SendCodeToEmailLoading());
    await postRepo.forgotPassword(email).then((result)
    {
      MyToast.showToast(context, msg: result.getOrThrow().message,color: Constants.appColor);

      if(result.isSuccess())
        {
          forgotPasswordButtonCont.reset();
          context.normalNewRoute(OtpCode());
          emit(SendCodeToEmailSuccess());
        }
      else{
        forgotPasswordButtonCont.reset();
        emit(SendCodeToEmailError());
      }
    });
  }


}