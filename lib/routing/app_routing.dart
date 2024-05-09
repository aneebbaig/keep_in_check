import 'package:flutter/material.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';
import 'package:keep_in_check/modules/expense_income/models/income_model.dart';
import 'package:keep_in_check/modules/expense_income/views/create_update_expense/create_update_expense_view.dart';
import 'package:keep_in_check/modules/expense_income/views/create_update_income/create_update_income_view.dart';
import 'package:keep_in_check/modules/loans/views/loan/loan_view.dart';
import 'package:keep_in_check/modules/loans/views/paid_loans/paid_loans_view.dart';
import 'package:keep_in_check/modules/savings/views/savings/saving_detail_view.dart';
import 'package:keep_in_check/routing/app_routes.dart';

import '../modules/core/views/login/login_view.dart';
import '../modules/core/views/navbar/navbar_view.dart';
import '../modules/core/views/onboarding/onboarding_view.dart';
import '../modules/savings/models/savings_model.dart';

class AppRouting {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case AppRoutes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case AppRoutes.navbarRoute:
        return MaterialPageRoute(builder: (_) => const NavBarView());

      case AppRoutes.createUpdateIncomeRoute:
        return MaterialPageRoute(
          builder: (_) => CreateUpdateIncomeView(
            model: settings.arguments as IncomeModel?,
          ),
        );
      case AppRoutes.createUpdateExpenseRoute:
        return MaterialPageRoute(
          builder: (_) => CreateUpdateExpenseView(
            model: settings.arguments as ExpenseModel?,
          ),
        );
      case AppRoutes.savingHistoryRoute:
        return MaterialPageRoute(
          builder: (_) => SavingsDetailScreen(
            savingsList: settings.arguments as List<SavingsModel>,
          ),
        );
      case AppRoutes.loanRoute:
        return MaterialPageRoute(builder: (_) => const LoanView());
      case AppRoutes.loansHistoryRoute:
        return MaterialPageRoute(builder: (_) => const LoansHistoryView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
