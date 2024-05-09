import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../routing/router.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  bool _dialogOpen = false;

  ConnectivityService._privateConstructor();

  static final ConnectivityService _instance =
      ConnectivityService._privateConstructor();

  factory ConnectivityService() {
    return _instance;
  }

  void initialize() {
    _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result);
    });
  }

  void _showNoInternetDialog() {
    if (!_dialogOpen) {
      showDialog(
        context: AppNavigator.navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Please check your internet connection and try again.'),
        ),
      );
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    bool isConnected = !result.contains(ConnectivityResult.none);
    if (!isConnected) {
      _showNoInternetDialog();
      _dialogOpen = true;
    }
    if (isConnected && _dialogOpen) {
      _dialogOpen = false;
      AppNavigator.pop();
    }
  }
}
