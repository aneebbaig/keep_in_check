
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep_in_check/modules/expense_income/viewmodel/income_expense_viewmodel.dart';
import 'package:keep_in_check/modules/loans/viewmodel/loan_viewmodel.dart';
import 'package:keep_in_check/modules/savings/viewmodel/savings_viewmodel.dart';
import 'package:keep_in_check/modules/transactions/viewmodel/transaction_viewmodel.dart';
import 'package:keep_in_check/routing/app_routing.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/theme/app_theme.dart';
import 'package:keep_in_check/modules/core/viewmodel/auth_viewmodel.dart';
import 'package:keep_in_check/modules/core/viewmodel/bottom_navbar_viewmodel.dart';
import 'package:keep_in_check/modules/core/viewmodel/onboarding_viewmodel.dart';

import 'package:keep_in_check/splash_view.dart';
import 'package:provider/provider.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        ChangeNotifierProvider(
          create: (context) => BottomNavBarViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => IncomeExpenseViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SavingsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoanViewModel(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            navigatorKey: AppNavigator.navigatorKey,
            onGenerateRoute: AppRouting.generateRoute,
            home: child,
          );
        },
        child: const SplashView(),
      ),
    );
  }
}
