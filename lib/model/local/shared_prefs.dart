import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static CacheHelper? instance;
  CacheHelper.internal();

  factory CacheHelper.getInstance()
  {
    return instance ??= CacheHelper.internal();
  }

  late SharedPreferences sharedPreferences;

  Future<void> cacheInit()async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveLoginState(bool isLoggedIn) async
  {
    await sharedPreferences.setBool('isLoggedIn', isLoggedIn);
  }
}
