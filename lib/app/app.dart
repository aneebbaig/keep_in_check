import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_in_check/app/router.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/viewmodel/auth_viewmodel.dart';
import 'package:keep_in_check/viewmodel/onboarding_viewmodel.dart';

import 'package:keep_in_check/views/splash_view.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OnBoardingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        home: const SplashView(),
      ),
    );
  }

  ThemeData appTheme() {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kTextGreyColor, // Change the color here
            width: 2.0,
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.montserrat(
          fontSize: 20,
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12,
        ),
      ),
    );
  }
}
