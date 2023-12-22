import 'package:flutter/material.dart';
import 'package:keep_in_check/app/router.dart';
import 'package:keep_in_check/views/login_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRouter.generateRoute,
      home: LoginView(),
    );
  }
}
