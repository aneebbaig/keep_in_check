import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_in_check/app/router.dart';
import 'package:keep_in_check/viewmodel/onboarding_viewmodel.dart';
import 'package:keep_in_check/views/login_view.dart';
import 'package:keep_in_check/views/onboarding/onboarding_view.dart';
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
