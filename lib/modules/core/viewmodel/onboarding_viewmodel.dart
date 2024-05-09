import 'package:flutter/material.dart';
import 'package:keep_in_check/routing/app_routes.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/const/app_images.dart';
import 'package:keep_in_check/modules/core/models/onboarding_model.dart';
import 'package:keep_in_check/services/shared_preferences_service.dart';

class OnBoardingViewModel extends ChangeNotifier {
  final List<OnBoardingModel> _screens = [
    OnBoardingModel(
      color: AppColors.kPrimaryColor,
      image: AppIcons.onBoardingOne,
      subtitle: 'Whats going to happen tomorrow?',
      title: 'Welcome to aking',
    ),
    OnBoardingModel(
      color: AppColors.kPrimaryPurpleColor,
      image: AppIcons.onBoardingTwo,
      subtitle: 'Get notified when work happens.',
      title: 'Work happens',
    ),
    OnBoardingModel(
      color: AppColors.kPrimaryBlueColor,
      image: AppIcons.onBoardingThree,
      subtitle: 'Task and assign them to colleagues.',
      title: 'Tasks and assign',
    )
  ];
  int _selectedIndex = 0;

  List<OnBoardingModel> get screens => _screens;
  int get selectedIndex => _selectedIndex;
  OnBoardingModel get selectedScreen => _screens[_selectedIndex];

  void nextOnBoardingScreen() async {
    if (_selectedIndex == 2) {
      await SharedPreferencesService()
          .setBool(SharedPreferencesService.hasOnboarded, true)
          .then(
            (value) => AppNavigator.pushReplacementNamed(AppRoutes.loginRoute),
          );

      return;
    }
    _selectedIndex++;
    notifyListeners();
  }
}
