import 'package:flutter/material.dart';
import 'package:keep_in_check/app/router.dart';
import 'package:keep_in_check/const/app_images.dart';
import 'package:keep_in_check/services/shared_preferences_manager.dart';
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
      decidePath();
    });
  }

  void decidePath() {
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      final hasOnboarded = SharedPreferencesManager()
          .getBool(SharedPreferencesManager.hasOnboarded, defaultValue: false);

      if (!hasOnboarded) {
        AppRouter.pushNamed(OnBoardingView.route);
      } else {
        AppRouter.pushNamed(LoginView.route);
      }
    });
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
