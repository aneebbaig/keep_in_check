import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/modules/expense_income/views/budget/budget_view.dart';
import 'package:keep_in_check/modules/loans/views/loan/loan_view.dart';
import 'package:keep_in_check/modules/savings/views/savings/savings_view.dart';
import 'package:keep_in_check/modules/transactions/views/transactions/transactions_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';


class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
  }

  PersistentTabConfig _navbarItem(
      {required String title, required IconData icon, required Widget screen}) {
    return PersistentTabConfig(
      screen: screen,
      item: ItemConfig(
        icon: Icon(icon),
        title: title,
        inactiveBackgroundColor: AppColors.kTextWhiteColor,
        activeForegroundColor: AppColors.kTextWhiteColor,
        activeColorSecondary: AppColors.kPrimaryPurpleColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      stateManagement: false,
      controller: _controller,
      tabs: [
        _navbarItem(
            icon: Icons.account_balance,
            title: "Budget",
            screen: const BudgetView()),
        _navbarItem(
            icon: Icons.sync_alt,
            title: "Transactions",
            screen: const TransactionsView()),
        _navbarItem(
            icon: Icons.savings, title: "Savings", screen: const SavingsView()),
        _navbarItem(
            icon: Icons.currency_exchange,
            title: "Loan",
            screen: const LoanView()),
      ],
      navBarBuilder: (navBarConfig) => Style2BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.kTextGreyColor.withOpacity(0.3),
              offset: const Offset(0, 2),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
