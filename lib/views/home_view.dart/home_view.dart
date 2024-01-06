import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/app/router.dart';
import 'package:keep_in_check/views/login_view.dart';

class HomeView extends StatelessWidget {
  static const route = '/homeView';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            AppRouter.pushReplacementNamed(LoginView.route);
          },
          icon: const Icon(
            Icons.exit_to_app,
          ),
        )
      ]),
    );
  }
}
