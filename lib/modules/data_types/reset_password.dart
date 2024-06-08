class ResetPasswordModel
{
  String email;
  String password;
  String conformPass;

  ResetPasswordModel({
    required this.email,
    required this.password,
    required this.conformPass,
  });

  Map<String,dynamic> toJson()
  {
    return
      {
        'email' : email,
        'password' : password,
        'password_confirm' : conformPass,
      };
  }
}