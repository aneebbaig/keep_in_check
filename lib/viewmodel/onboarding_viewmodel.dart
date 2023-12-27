import 'package:flutter/material.dart';
import 'package:keep_in_check/app/router.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/const/app_images.dart';
import 'package:keep_in_check/models/onboarding_model.dart';
import 'package:keep_in_check/services/shared_preferences_manager.dart';
import 'package:keep_in_check/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingViewModel extends ChangeNotifier {
  final List<OnBoardingModel> _screens = [
    OnBoardingModel(
      color: AppColors.kPrimaryRedColor,
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
      await SharedPreferencesManager()
          .setBool(SharedPreferencesManager.hasOnboarded, true)
          .then(
            (value) => AppRouter.pushReplacementNamed(LoginView.route),
          );

      return;
    }
    _selectedIndex++;
    notifyListeners();
  }
}
