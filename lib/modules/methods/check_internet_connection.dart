import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/modules/base_widgets/snackBar.dart';
class CheckInternetConnection
{
  static CheckInternetConnection? checkInternetConnection;

  static CheckInternetConnection getInstance()
  {
    return checkInternetConnection ??= CheckInternetConnection();
  }

  void startInternetInterceptor(context)
  {
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((newState) {
      if(newState == ConnectivityResult.none)
      {
        // MySnackBar.showSnackBar(
        //     context: context,
        //     message: 'Error',
        //     color: Colors.red
        // );
      }
      else{
        // MySnackBar.showSnackBar(
        //     context: context,
        //     message: 'Done',
        //     color: Colors.green
        // );
      }
    });
  }
}