import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';
import 'package:keep_in_check/modules/expense_income/viewmodel/income_expense_viewmodel.dart';
import 'package:keep_in_check/modules/expense_income/views/create_update_expense/widgets/expense_list_tile.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/utils/app_utils.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/add_height_width.dart';
import '../../budget/widgets/total_amount_widget.dart';

class ExpenseListView extends StatefulWidget {
  final List<ExpenseModel> expenseList;
  final int totalBudget;
  final int totalExpenses;
  const ExpenseListView(
      {super.key,
      required this.expenseList,
      required this.totalBudget,
      required this.totalExpenses});

  @override
  State<ExpenseListView> createState() => _ExpenseListViewState();
}

class _ExpenseListViewState extends State<ExpenseListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddHeight(0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TotalAmountWidget(
              title: "Total Budget",
              amount: widget.totalBudget,
            ),
            const AddWidth(0.1),
            TotalAmountWidget(
              title: "Total Expenses",
              amount: widget.totalExpenses,
            ),
          ],
        ),
        const AddHeight(0.05),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const AddHeight(0.02),
            itemCount: widget.expenseList.length,
            itemBuilder: (context, index) {
              return Slidable(
                closeOnScroll: true,
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        AppUtils.showProgressDialog();
                        context
                            .read<IncomeExpenseViewModel>()
                            .deleteExpense(widget.expenseList[index].id);
                        AppNavigator.pop();
                      },
                      // backgroundColor: const Color(0xFF7BC043),
                      foregroundColor: Colors.black,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ExpenseListTile(
                  expenseModel: widget.expenseList[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
