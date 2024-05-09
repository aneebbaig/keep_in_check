import 'package:flutter/material.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';
import 'package:keep_in_check/modules/transactions/controllers/transaction_controller.dart';

import '../models/transaction_model.dart';

enum OperationType {
  spending,
  cashback,
}

class TransactionViewmodel extends ChangeNotifier {
  final TransactionController _transactionController = TransactionController();
  List<TransactionModel> _transactionModel = [];
  bool _isLoading = false;

  List<TransactionModel> get transactionsList => _transactionModel;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value, {bool notify = true}) {
    _isLoading = value;

    if (notify) {
      notifyListeners();
    }
  }

  void setTransactionModel(List<TransactionModel> value) {
    _transactionModel = value;
  }

  Future<void> getAllTransactions() async {
    try {
      _transactionModel = await _transactionController.getAllTransactions();
    } catch (e) {
      rethrow;
      // AppUtils.showRetryDialog(
      //   onRetry: () async {
      //     setIsLoading(true);
      //     await getAllTransactions();
      //     setIsLoading(false);
      //   },
      // );
    }
  }

  Future<void> performTransaction({
    required DateTime dateTime,
    required OperationType operationType,
    required int transactionAmount,
    required ExpenseModel perfromTransactionOn,
    required int spentBudget,
    required int allocatedBudget,
  }) async {
    int newSpent = 0;
    if (operationType == OperationType.spending) {
      newSpent = spentBudget + transactionAmount;
    } else {
      newSpent = spentBudget - transactionAmount;
    }
    try {
      await _transactionController.performTransaction(
        amount: newSpent,
        perfromTransactionOn: perfromTransactionOn,
      );
      await _transactionController.addTransaction(
        TransactionModel(
          transactionDate: dateTime,
          operationType: operationType,
          id: "",
          performTransactionOn: perfromTransactionOn,
          spentBeforeTransaction: allocatedBudget,
          spentAfterTransaction: newSpent,
          enteredAmount: transactionAmount,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
