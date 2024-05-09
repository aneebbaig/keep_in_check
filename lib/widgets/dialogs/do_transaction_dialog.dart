import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';
import 'package:keep_in_check/modules/expense_income/viewmodel/income_expense_viewmodel.dart';
import 'package:keep_in_check/modules/transactions/viewmodel/transaction_viewmodel.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/services/field_validations.dart';
import 'package:keep_in_check/services/snackbar_service.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_circular_progress.dart';
import 'package:keep_in_check/widgets/custom/custom_elevated_button.dart';
import 'package:keep_in_check/widgets/custom/custom_text_form_field.dart';
import 'package:keep_in_check/widgets/custom/custom_text_widget.dart';
import 'package:provider/provider.dart';

import '../../const/app_sizing.dart';
import '../../utils/app_utils.dart';

enum BudgetStatus {
  over,
  under,
  equal,
}

class DoTransactionDialog extends StatefulWidget {
  final ExpenseModel model;
  const DoTransactionDialog({super.key, required this.model});

  @override
  State<DoTransactionDialog> createState() => _DoTransactionDialogState();
}

class _DoTransactionDialogState extends State<DoTransactionDialog> {
  final GlobalKey<FormState> _addIncomeFormKey = GlobalKey<FormState>();

  late int allocatedBudget;
  // late int budgetLeft;
  late int totalSpentAfterTransaction;
  late BudgetStatus budgetStatus;
  late Color budgetColor;
  late String budgetText;
  bool isLoading = false;

  DateTime dateTime = DateTime.now();
  final dateFormat = DateFormat("dd-MMM-yyyy");

  ///////////////////////
  final TextEditingController _transactionAmountController =
      TextEditingController();
  final TextEditingController _calculateBudgetController =
      TextEditingController();
  final TextEditingController _allocatedBudgetController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  //TextEditingController sourceController = TextEditingController();

  ///////////////
  OperationType operationType = OperationType.spending;

  @override
  void initState() {
    super.initState();

    _setValues();
  }

  _setValues() {
    allocatedBudget = widget.model.budget;
    _allocatedBudgetController.text = allocatedBudget.toString();
    // budgetLeft = allocatedBudget - widget.model.spentBudget;
    // _remainingBudgetController.text = budgetLeft.toString();
    totalSpentAfterTransaction = widget.model.spentBudget;
    _calculateBudgetController.text = totalSpentAfterTransaction.toString();
    _dateController.text = dateFormat.format(dateTime);
    _setBudgetValues();
  }

  _setBudgetValues() {
    if (totalSpentAfterTransaction > allocatedBudget) {
      budgetStatus = BudgetStatus.over;
      budgetColor = AppColors.kExpenseRedColor;
      budgetText = "You have exceeded your budget";
    }
    if (totalSpentAfterTransaction == allocatedBudget) {
      budgetStatus = BudgetStatus.equal;
      budgetColor = AppColors.kExpenseYellowColor;
      budgetText = "Warning! You have exhausted your budget";
    }
    if (totalSpentAfterTransaction < allocatedBudget) {
      budgetStatus = BudgetStatus.under;
      budgetColor = AppColors.kIncomGreenColor;
      budgetText = "You are within your budget";
    }
  }

  void _radioOnChanged(String? value) {
    setState(() {
      operationType = value! == OperationType.cashback.name
          ? OperationType.cashback
          : OperationType.spending;
      _calculateNewAmount();
      _setBudgetValues();
    });
  }

  _calculateNewAmount() {
    if (_transactionAmountController.text.isEmpty) {
      totalSpentAfterTransaction = widget.model.spentBudget;
    } else if (operationType == OperationType.spending) {
      totalSpentAfterTransaction = widget.model.spentBudget +
          int.parse(_transactionAmountController.text);
    } else {
      final spent = widget.model.spentBudget -
          int.parse(_transactionAmountController.text);
      if (spent.isNegative) {
        totalSpentAfterTransaction = 0;
      } else {
        totalSpentAfterTransaction = spent;
      }
    }
    _calculateBudgetController.text = totalSpentAfterTransaction.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSizing.kVerticalPadding,
        left: AppSizing.kHorizontalPadding,
        right: AppSizing.kHorizontalPadding,
      ),
      child: Form(
        key: _addIncomeFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                controller: _dateController,
                label: "Date",
                hintText: "Pick a date",
                readOnly: true,
                validator: AppValidators.requiredField,
                onTap: () {
                  AppUtils.showAppDatePicker(
                    context: context,
                    onDateSelected: (date) {
                      dateTime = date;
                      String formattedDate = dateFormat.format(date);
                      setState(
                        () {
                          _dateController.text = formattedDate;
                        },
                      );
                    },
                  );
                },
              ),
              const AddHeight(0.01),
              CustomTextFormField(
                controller: _allocatedBudgetController,
                label: "Allocated Budget",
                hintText: "Allocated Budget",
                readOnly: true,
                prefix: Container(
                  alignment: Alignment.center,
                  width: 0.1.sw,
                  child: const CustomText("PKR"),
                ),
              ),
              Row(
                children: [
                  RadioMenuButton(
                    value: OperationType.spending.name,
                    groupValue: operationType.name,
                    onChanged: _radioOnChanged,
                    child: const CustomText("Spending"),
                  ),
                  RadioMenuButton(
                    value: OperationType.cashback.name,
                    groupValue: operationType.name,
                    onChanged: _radioOnChanged,
                    child: const CustomText("Cashback"),
                  ),
                ],
              ),
              const AddHeight(0.01),
              CustomTextFormField(
                controller: _transactionAmountController,
                hintText: "Enter transaction Amount",
                label: "Transaction Amount",
                validator: (value) {
                  if (value == null || value.isEmpty || value == "0") {
                    return "Please Enter an amount";
                  }
                  if (operationType == OperationType.cashback) {
                    if ((widget.model.spentBudget - int.parse(value))
                        .isNegative) {
                      return "Cashback exceeds the allocated budget";
                    }
                  }
                  return null;
                },
                prefix: Container(
                  alignment: Alignment.center,
                  width: 0.1.sw,
                  child: const CustomText("PKR"),
                ),
                keyboardInputType:
                    const TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                ],
                onChanged: (_) {
                  setState(() {
                    _calculateNewAmount();
                    _setBudgetValues();
                  });
                },
              ),
              const AddHeight(0.01),
              CustomTextFormField(
                controller: _calculateBudgetController,
                borderColor: budgetColor,
                label: "Total Spent after Transaction",
                hintText: "Enter Transaction amount",
                readOnly: true,
                prefix: Container(
                  alignment: Alignment.center,
                  width: 0.1.sw,
                  child: const CustomText("PKR"),
                ),
              ),
              CustomText(
                budgetText,
                textColor: budgetColor,
                fontSize: 12,
              ),
              const AddHeight(0.03),
              if (!isLoading) ...[
                CustomElevatedButton(
                  buttonText: "Perfom Transaction",
                  onPressed: () async {
                    if (_addIncomeFormKey.currentState!.validate()) {
                      AppUtils.showProgressDialog();
                      try {
                        await context
                            .read<TransactionViewmodel>()
                            .performTransaction(
                              transactionAmount:
                                  int.parse(_transactionAmountController.text),
                              spentBudget: widget.model.spentBudget,
                              allocatedBudget: allocatedBudget,
                              dateTime: dateTime,
                              operationType: operationType,
                              perfromTransactionOn: widget.model,
                            );
                        if (context.mounted) {
                          await context
                              .read<IncomeExpenseViewModel>()
                              .getAllExpense();
                        }

                        AppNavigator.pop();
                        SnackbarService.showSnackbar("Transaction Successfull");
                      } catch (e) {
                        SnackbarService.showSnackbar(e.toString());
                      }
                      AppNavigator.pop();
                    }
                  },
                ),
              ],
              if (isLoading) ...[
                const CustomCircularProgressIndicator(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
