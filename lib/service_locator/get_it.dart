import 'package:gardenia/model/local/shared_prefs.dart';
import 'package:gardenia/view_model/bottomNavBar/cubit.dart';
import 'package:gardenia/view_model/onBoarding/cubit.dart';
import 'package:get_it/get_it.dart';

class Services
{
  static Services? services;

  Services.internal();

  factory Services.getInstance()
  {
    return services ??= Services.internal();
  }


  GetIt getIt = GetIt.instance;

  void initDependencies() {}

}