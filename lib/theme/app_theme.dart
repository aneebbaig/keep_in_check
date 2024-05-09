import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_sizing.dart';

import '../const/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kScaffoldBgColor,
    inputDecorationTheme: const InputDecorationTheme(
      //filled: true,
      isDense: false,
      // fillColor: AppColors.kTextFormFieldBorderColor,
      contentPadding: EdgeInsets.symmetric(
          vertical: AppSizing.kVerticalFormFieldPadding,
          horizontal: AppSizing.kHorizontalFormFieldPadding),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizing.kDefaultBorderRadius),
        ),
        borderSide: BorderSide(
          color: AppColors.kTextFormFieldBorderColor, // Change the color here
          width: 2.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizing.kDefaultBorderRadius),
        ),
        borderSide: BorderSide(
          color: AppColors.kTextFormFieldBorderColor, // Change the color here
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizing.kDefaultBorderRadius),
        ),
        borderSide: BorderSide(
          color: AppColors.kTextFormFieldBorderColor, // Change the color here
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizing.kDefaultBorderRadius),
        ),
        borderSide: BorderSide(
          color: AppColors.kTextFormFieldBorderColor, // Change the color here
          width: 2.0,
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor:
          MaterialStateColor.resolveWith((states) => AppColors.kPrimaryColor),
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.kTextBlackColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.kTextBlackColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        color: AppColors.kTextBlackColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.kTextBlackColor,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        color: AppColors.kTextBlackColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        color: AppColors.kTextBlackColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        color: AppColors.kTextBlackColor,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        color: AppColors.kTextBlackColor,
      ),
    ),
  );
}
