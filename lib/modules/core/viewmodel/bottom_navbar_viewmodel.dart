import 'package:flutter/material.dart';
import 'package:keep_in_check/modules/expense_income/views/budget/budget_view.dart';

class BottomNavBarViewModel extends ChangeNotifier {
  final List<Widget> _screens = [
    const BudgetView(),
    Container(),
    Container(),
    Container(),
  ];
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  Widget get currentScreen => _screens[_currentIndex];

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
