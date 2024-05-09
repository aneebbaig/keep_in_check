// app/router.dart
import 'package:flutter/material.dart';

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static pushNamed(String route, {Object? arguments}) {
    navigatorKey.currentState!.pushNamed(
      route,
      arguments: arguments,
    );
  }

  static pop() {
    navigatorKey.currentState!.pop();
  }

  static pushReplacementNamed(String route, {Object? arguments}) {
    navigatorKey.currentState!.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  static pushNamedAndRemoveUntil(String route, {String? destinationRoute}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      route,
      destinationRoute == null
          ? (Route<dynamic> route) => false
          : ModalRoute.withName(
              destinationRoute,
            ),
    );
  }
}
