// app/router.dart
import 'package:flutter/material.dart';
import 'package:keep_in_check/views/login_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginView.route:
        return MaterialPageRoute(builder: (_) => const LoginView());
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
}
