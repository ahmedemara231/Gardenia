import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper
{

  static HiveHelper? instance;
  HiveHelper();

  static HiveHelper getInstance()
  {
    return instance ??= HiveHelper();
  }

  void init()async
  {
    Hive.init((await getApplicationCacheDirectory()).path);
  }

  Future<Box> openBox(String name)async
  {
    return await Hive.openBox(name);
  }
}