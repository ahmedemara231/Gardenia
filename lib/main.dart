import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gardenia/model/local/Hive/registers.dart';
import 'package:gardenia/model/remote/stripe/api_service/constants.dart';
import 'package:gardenia/view_model/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/model/local/Hive/hive.dart';
import 'package:gardenia/model/local/secure_storage.dart';
import 'package:gardenia/model/local/shared_prefs.dart';

import 'gardenia.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = StripeApiConstants.publishableKey;

  await CacheHelper.getInstance().cacheInit();
  SecureStorage.getInstance().init();
  HiveHelper.getInstance().init();

  await Future.delayed(
    const Duration(milliseconds: 250),()async {
      await HiveRegisters.getInstance().registerPostsBox();
      await HiveRegisters.getInstance().registerPlantsBox();
  },);
  Bloc.observer = MyBlocObserver();
  if(kReleaseMode){
    // crashlitics
  }
  runApp(const Gardenia());
}