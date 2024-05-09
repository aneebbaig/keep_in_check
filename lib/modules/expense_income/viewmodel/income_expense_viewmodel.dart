import 'package:flutter/material.dart';
import 'package:keep_in_check/modules/expense_income/controllers/income_expense_controller.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';
import 'package:keep_in_check/modules/expense_income/models/income_model.dart';

import 'package:keep_in_check/services/snackbar_service.dart';

enum TransactionType {
  income,
  expense,
}

class IncomeExpenseViewModel extends ChangeNotifier {
  TransactionType selectedTransactionType = TransactionType.income;
  final IncomeExpenseController _controller = IncomeExpenseController();

  int totalIncome = 0;
  int totalExpense = 0;
  int totalBudget = 0;
  int _balance = 0;

  bool _isLoading = false;
  List<IncomeModel> _incomeList = [];
  List<ExpenseModel> _expenseList = [];

  bool get isLoading => _isLoading;
  List<IncomeModel> get incomeList => _incomeList;
  List<ExpenseModel> get expenseList => _expenseList;
  int get balance => _balance;

  void setTransactionType(TransactionType type) {
    selectedTransactionType = type;
    notifyListeners();
  }

  void setBalance(int value) {
    _balance = value;
    notifyListeners();
  }

  void updateBalance() {
    _balance = totalIncome - totalExpense;
    notifyListeners();
  }

  void setIsLoading(bool value, {bool notify = true}) {
    _isLoading = value;
    if (notify) {
      notifyListeners();
    }
  }

  void deleteExpense(String id) async {
    setIsLoading(true);
    final tempExpense = _expenseList.where((element) => element.id == id).first;

    try {
      _expenseList.removeWhere(
        (expense) => expense.id == id,
      );
      notifyListeners();
      await _controller.deleteExpense(id: id);
      setIsLoading(false);
    } catch (e) {
      _expenseList.add(tempExpense);
      SnackbarService.showSnackbar(e.toString());
      setIsLoading(false);
    }
  }

  void deleteIncome(String id) async {
    setIsLoading(true);
    final tempIncome = _incomeList.where((element) => element.id == id).first;

    try {
      _incomeList.removeWhere(
        (income) => income.id == id,
      );
      notifyListeners();
      await _controller.deleteIncome(id: id);
      setIsLoading(false);
    } catch (e) {
      _incomeList.add(tempIncome);
      SnackbarService.showSnackbar(e.toString());
      setIsLoading(false);
    }
  }

  void updateExpenseList({
    required String name,
    required int amount,
    required String id,
    required DateTime createdAt,
    required bool isExtra,
    required int spentBudget,
  }) async {
    setIsLoading(true);

    try {
      await _controller.updateExpense(
        id: id,
        name: name,
        budget: amount,
        createdAt: createdAt,
        isExtra: isExtra,
        spentBudget: spentBudget,
      );

      await getAllExpense();
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
    }
    setIsLoading(false);
  }

  void updateIncomeList({
    required String name,
    required int amount,
    required String id,
    required DateTime createdAt,
    required bool isUSD,
    required bool isExtra,
  }) async {
    setIsLoading(true);

    try {
      await _controller.updateIncome(
        id: id,
        name: name,
        amount: amount,
        isUSD: isUSD,
        createdAt: createdAt,
        isExtra: isExtra,
      );

      await getAllIncome();
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
    }
    setIsLoading(false);
  }

  void addToExpenseList({
    required String name,
    required int budget,
    required DateTime createdAt,
    required bool isExtra,
  }) async {
    setIsLoading(true);

    try {
      await _controller.addExpense(
        name: name,
        budget: budget,
        dateTime: createdAt,
        isExtra: isExtra,
      );
      await getAllExpense();
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
    }
    setIsLoading(false);
  }

  void addToIncomeList({
    required String name,
    required int amount,
    required bool isUSD,
    required DateTime createdAt,
    required bool isExtra,
  }) async {
    setIsLoading(true);

    try {
      await _controller.addIncome(
        name: name,
        amount: amount,
        isUSD: isUSD,
        createdAt: createdAt,
        isExtra: isExtra,
      );

      await getAllIncome();
    } catch (e) {
      SnackbarService.showSnackbar(e.toString());
    }
    setIsLoading(false);
  }

  Future<void> getAllIncome() async {
    try {
      _incomeList = await _controller.getAllIncome();
      totalIncome = _incomeList.fold(0, (sum, income) => sum + income.amount);
      updateBalance();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getAllExpense() async {
    try {
      setIsLoading(true);
      _expenseList = await _controller.getAllExpenses();
      totalBudget = _expenseList.fold(
        0,
        (sum, expense) => sum + expense.budget,
      );
      totalExpense = _expenseList.fold(
        0,
        (sum, expense) => sum + expense.spentBudget,
      );
      updateBalance();
      setIsLoading(false);
    } catch (e) {
      rethrow;
    }
  }
}
