import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/modules/expense_income/views/create_update_expense/widgets/expense_listview_widget.dart';
import 'package:keep_in_check/modules/expense_income/views/create_update_income/widgets/income_listview_widget.dart';

import 'package:keep_in_check/modules/expense_income/viewmodel/income_expense_viewmodel.dart';
import 'package:keep_in_check/routing/app_routes.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_appbar.dart';

import 'package:keep_in_check/widgets/custom/custom_screen_padding.dart';
import 'package:keep_in_check/widgets/custom/custom_text_widget.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/custom/custom_circular_progress.dart';
import '../../../../widgets/custom/custom_tab_button.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({super.key});

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  bool showOptions = false;

  @override
  void initState() {
    fetchData(false);
    super.initState();
  }

  Future<void> fetchData(bool notify) async {
    context.read<IncomeExpenseViewModel>().setIsLoading(true, notify: notify);
    if (context.read<IncomeExpenseViewModel>().selectedTransactionType ==
        TransactionType.income) {
      await context.read<IncomeExpenseViewModel>().getAllIncome();
    } else {
      await context.read<IncomeExpenseViewModel>().getAllExpense();
    }
    if (context.mounted) {
      context.read<IncomeExpenseViewModel>().setIsLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        canBePopped: false,
        title: "Budget",
        actions: [
          IconButton(
            onPressed: () {
              AppNavigator.pushNamed(
                context
                            .read<IncomeExpenseViewModel>()
                            .selectedTransactionType ==
                        TransactionType.income
                    ? AppRoutes.createUpdateIncomeRoute
                    : AppRoutes.createUpdateExpenseRoute,
              );
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ],
      ),
      body: CustomScreenPadding(
        child: Consumer<IncomeExpenseViewModel>(
          builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomTabButton(
                        buttonText: "Income",
                        isSelected: provider.selectedTransactionType ==
                            TransactionType.income,
                        onTap: () {
                          provider.setTransactionType(TransactionType.income);
                          fetchData(true);
                        },
                      ),
                    ),
                    const AddWidth(0.02),
                    Flexible(
                      child: CustomTabButton(
                        buttonText: "Expense",
                        isSelected: provider.selectedTransactionType ==
                            TransactionType.expense,
                        onTap: () {
                          provider.setTransactionType(TransactionType.expense);
                          fetchData(true);
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Consumer<IncomeExpenseViewModel>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return const CustomCircularProgressIndicator();
                      }
                      if ((provider.selectedTransactionType ==
                                  TransactionType.income &&
                              provider.incomeList.isEmpty) ||
                          (provider.selectedTransactionType ==
                                  TransactionType.expense &&
                              provider.expenseList.isEmpty)) {
                        return const Center(
                          child: CustomText("No data Found"),
                        );
                      }

                      if (provider.selectedTransactionType ==
                          TransactionType.income) {
                        return IncomeListViewWidget(
                          incomeList:
                              context.read<IncomeExpenseViewModel>().incomeList,
                          totalAmount: context
                              .read<IncomeExpenseViewModel>()
                              .totalIncome,
                        );
                      }

                      return ExpenseListView(
                        expenseList:
                            context.read<IncomeExpenseViewModel>().expenseList,
                        totalBudget:
                            context.read<IncomeExpenseViewModel>().totalBudget,
                        totalExpenses:
                            context.read<IncomeExpenseViewModel>().totalExpense,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
