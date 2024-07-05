import 'package:gardenia/model/local/Hive/hive.dart';
import 'package:hive/hive.dart';

class HiveRegisters
{

  static HiveRegisters? instance;
  HiveRegisters();

  static HiveRegisters getInstance()
  {
    return instance??= HiveRegisters();
  }

  late Box _postsBox;

  Future<void> registerPostsBox()async
  {
    _postsBox = await HiveHelper.getInstance().openBox('posts');
  }

  late Box _plantsBox;

  Future<void> registerPlantsBox()async
  {
    _postsBox = await HiveHelper.getInstance().openBox('plants');
  }

  Box get getPostsBox
  {
    return _postsBox;
  }

  Box get getPlantsBox
  {
    return _plantsBox;
  }


}