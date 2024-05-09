import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/extensions.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';
import 'package:keep_in_check/routing/app_routes.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/widgets/custom/custom_list_tile.dart';
import 'package:keep_in_check/widgets/dialogs/do_transaction_dialog.dart';

import '../../../../../utils/app_utils.dart';
import '../../../../../widgets/add_height_width.dart';
import '../../../../../widgets/custom/custom_tag_widget.dart';
import '../../../../../widgets/custom/custom_text_widget.dart';

class ExpenseListTile extends StatelessWidget {
  final ExpenseModel expenseModel;

  const ExpenseListTile({
    super.key,
    required this.expenseModel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (expenseModel.isExtra) ...[
                const ExtraTagWidget(),
                const AddHeight(0.01),
              ],
              CustomText(
                expenseModel.name,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const AddHeight(0.01),
              CustomText(
                "Budget: PKR ${expenseModel.budget.formatAsDecimals().toString()}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const AddHeight(0.002),
              CustomText(
                "Spent: PKR ${expenseModel.spentBudget.formatAsDecimals().toString()}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            onPressed: () {
              AppNavigator.pushNamed(
                AppRoutes.createUpdateExpenseRoute,
                arguments: expenseModel,
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          if (!expenseModel.isExtra)
            IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              onPressed: () {
                AppUtils.showDialogWithContent(
                  context: context,
                  barrierDismissable: false,
                  heading: "Perform a Transaction",
                  dialog: DoTransactionDialog(
                    model: expenseModel,
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.plus_slash_minus,
              ),
            )
        ],
      ),
    );
  }
}
