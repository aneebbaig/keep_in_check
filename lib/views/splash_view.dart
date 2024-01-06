import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/app/router.dart';
import 'package:keep_in_check/const/app_images.dart';
import 'package:keep_in_check/services/shared_preferences_service.dart';
import 'package:keep_in_check/views/home_view.dart/home_view.dart';
import 'package:keep_in_check/views/login_view.dart';
import 'package:keep_in_check/views/onboarding/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _decidePath();
    });
  }

  Future<void> _decidePath() async {
    final user = FirebaseAuth.instance.currentUser;
    await Future.delayed(const Duration(seconds: 3));

    final hasOnboarded = SharedPreferencesService()
        .getBool(SharedPreferencesService.hasOnboarded, defaultValue: false);

    if (!hasOnboarded) {
      AppRouter.pushNamed(OnBoardingView.route);
    } else {
      AppRouter.pushNamed(user == null ? LoginView.route : HomeView.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppIcons.appLogo,
              scale: 2,
            ),
          ],
        ),
      ),
    );
  }
}
