import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/const/app_images.dart';
import 'package:keep_in_check/services/shared_preferences_service.dart';

import 'routing/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _decidePath();
  }

  Future<void> _decidePath() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      _showConnectivityDialog();
    } else {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;
    final hasOnboarded = SharedPreferencesService()
        .getBool(SharedPreferencesService.hasOnboarded, defaultValue: false);

    if (!hasOnboarded) {
      AppNavigator.pushReplacementNamed(AppRoutes.onBoardingRoute);
    } else if (user == null) {
      AppNavigator.pushReplacementNamed(AppRoutes.loginRoute);
    } else {
      AppNavigator.pushReplacementNamed(AppRoutes.navbarRoute);
    }
  }

  void _showConnectivityDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        title: Text('No Internet Connection'),
        content: Text('Please check your internet connection and try again.'),
      ),
    );
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
