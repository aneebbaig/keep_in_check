import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_sizing.dart';
import 'package:keep_in_check/routing/router.dart';

import '../modules/savings/models/month_summary_model.dart';
import '../modules/savings/models/savings_model.dart';
import '../services/api_service.dart';
import '../widgets/dialogs/progress_dialog.dart';
import '../widgets/dialogs/retry_dialog.dart';

class AppUtils {
  static Future<int> convertToPKR(int amount) async {
    final response = await ApiService.getExchangeRates();
    return (amount * response["rates"]["PKR"]).toInt();
  }

  static void showAppDatePicker({
    required BuildContext context,
    required Function(DateTime) onDateSelected,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      onDateSelected(picked);
    }
  }

  static Future<void> showRetryDialog({
    String title = "Error",
    String message = "Some Error Occured. Please try again",
    required VoidCallback onRetry,
  }) async {
    return showDialog<void>(
      context: AppNavigator.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return RetryDialog(
          title: title,
          message: message,
          onRetry: onRetry,
        );
      },
    );
  }

  static void showProgressDialog() {
    showDialog(
      context: AppNavigator.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const ProgressDialog(); // Replace with your dialog content
      },
    );
  }

  static List<MonthSummary> divideByMonth(List<SavingsModel> savingsList) {
    List<MonthSummary> monthSummaries = List.generate(
        12,
        (_) => MonthSummary(
            monthAndYear: "",
            totalSavingsPKR: 0,
            totalSavingsUSD: 0,
            savingsList: []));

    for (SavingsModel saving in savingsList) {
      String monthAndYear =
          "${getMonthName(saving.dateTime.month)} ${saving.dateTime.year}";

      int monthIndex = saving.dateTime.month - 1;
      if (saving.isUSD) {
        monthSummaries[monthIndex].totalSavingsUSD += saving.savingAmount;
      } else {
        monthSummaries[monthIndex].totalSavingsPKR += saving.savingAmount;
      }

      monthSummaries[monthIndex].savingsList.add(saving);

      if (monthSummaries[monthIndex].monthAndYear.isEmpty) {
        monthSummaries[monthIndex].monthAndYear = monthAndYear;
      }
    }

    return monthSummaries;
  }

  static String getMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Invalid month number';
    }
  }

  static Future<void> showDialogWithContent({
    required BuildContext context,
    required String heading,
    required Widget dialog,
    required bool barrierDismissable,
    bool showCloseButton = true,
  }) async {
    return showDialog<void>(
      barrierDismissible: barrierDismissable,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSizing.kVerticalPadding,
                  left: AppSizing.kHorizontalPadding,
                  right: AppSizing.kHorizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      heading,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (showCloseButton)
                      IconButton(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                  ],
                ),
              ),
              dialog,
            ],
          ),
        );
      },
    );
  }

  static (Timestamp, Timestamp) getStartEndDate(DateTime dateTime) {
    DateTime startOfMonth = DateTime(
        dateTime.year, dateTime.month, 1); // First day of the selected month
    DateTime endOfMonth = DateTime(
        dateTime.year, dateTime.month + 1, 1); // First day of the next month

    Timestamp startTimestamp = Timestamp.fromDate(startOfMonth);
    Timestamp endTimestamp = Timestamp.fromDate(endOfMonth);

    return (startTimestamp, endTimestamp);
  }
}
