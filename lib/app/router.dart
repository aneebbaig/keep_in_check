// app/router.dart
import 'package:flutter/material.dart';
import 'package:keep_in_check/views/login_view.dart';
import 'package:keep_in_check/views/onboarding/onboarding_view.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginView.route:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case OnBoardingView.route:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static pushNamed(String route, {Object? arguments}) {
    navigatorKey.currentState!.pushNamed(
      route,
      arguments: arguments,
    );
  }

  static pushReplacementNamed(String route, {Object? arguments}) {
    navigatorKey.currentState!.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }
}
