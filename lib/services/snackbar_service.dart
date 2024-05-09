import 'package:flutter/material.dart';
import 'package:keep_in_check/routing/router.dart';

class SnackbarService {
  static void showSnackbar(String message) {
    ScaffoldMessenger.of(AppNavigator.navigatorKey.currentContext!)
        .removeCurrentSnackBar();
    ScaffoldMessenger.of(AppNavigator.navigatorKey.currentContext!)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.fixed,
        // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        backgroundColor: Colors.grey,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
