import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/models/firebase_exception.dart';
import 'package:keep_in_check/modules/savings/controllers/savings_controller.dart';
import 'package:keep_in_check/modules/savings/models/month_summary_model.dart';
import 'package:keep_in_check/services/snackbar_service.dart';
import 'package:keep_in_check/utils/app_utils.dart';

import '../models/savings_model.dart';

class SavingsViewModel extends ChangeNotifier {
  final SavingsController _controller = SavingsController();

  bool _isLoading = false;
  List<SavingsModel> savingsList = [];
  List<MonthSummary> monthSummaries = [];
  int totalPKRSavings = 0;
  int totalUSDSavings = 0;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value, {bool notify = true}) {
    _isLoading = value;
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> addSaving(SavingsModel model) async {
    try {
      await _controller.addSaving(model);
      await getAllSavings();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSaving(String id) async {
    try {
      await _controller.deleteSaving(id);
      await getAllSavings();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getAllSavings({DateTime? date}) async {
    try {
      savingsList = await _controller.getAllSavings(dateTime: date);
      totalPKRSavings = savingsList.fold<int>(
        0,
        (sum, saving) {
          if (!saving.isUSD) {
            return saving.savingAmount + sum;
          } else {
            return sum + 0;
          }
        },
      );
      totalUSDSavings = savingsList.fold<int>(
        0,
        (sum, saving) {
          if (saving.isUSD) {
            return saving.savingAmount + sum;
          } else {
            return sum + 0;
          }
        },
      );
      monthSummaries = AppUtils.divideByMonth(savingsList);
      notifyListeners();
    } catch (e) {
      if (e is CustomFirebaseException) {
        SnackbarService.showSnackbar("Cannot Fetch Savings");
      }
    }
  }
}
