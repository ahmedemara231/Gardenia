import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static CacheHelper? instance;
  CacheHelper();

  factory CacheHelper.getInstance()
  {
    return instance ??= CacheHelper();
  }

  late SharedPreferences sharedPreferences;

  Future<void> cacheInit()async
  {
    sharedPreferences = await SharedPreferences.getInstance();
    log('Done');
  }

  Future<void> setData({
    required String key,
    required dynamic value,
})async
  {
    switch(value)
    {
      case String:
        await sharedPreferences.setString(key, value);

      case int:
        await sharedPreferences.setInt(key, value);

      case bool:
        await sharedPreferences.setBool(key, value);

      case double :
        await sharedPreferences.setDouble(key, value);

      default:
        await sharedPreferences.setStringList(key, value);
    }
  }

  dynamic getData(String key)async
  {
    return sharedPreferences.get(key);
  }
}
