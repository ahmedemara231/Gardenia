import 'package:gardenia/model/remote/api_service/service/languages_and_methods.dart';

class UpdateUserData
{
  String name;
  String email;
  String? pass;
  String? confirmPass;

  UpdateUserData({required this.name, required this.email, required this.pass, required this.confirmPass});

  Map<String,String?> toJson()
  {
    return
      {
        '_method' : Methods.PATCH,
        'username' : name,
        'email' : email,
        'password' : pass,
      };
  }

}