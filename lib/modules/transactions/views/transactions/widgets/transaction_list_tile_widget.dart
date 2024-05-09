import 'package:flutter/material.dart';

import '../../../../../const/app_colors.dart';
import '../../../../../widgets/add_height_width.dart';
import '../../../../../widgets/custom/custom_list_tile.dart';
import '../../../../../widgets/custom/custom_text_widget.dart';
import '../../../models/transaction_model.dart';
import '../../../viewmodel/transaction_viewmodel.dart';

class TransactionListTile extends StatelessWidget {
  final TransactionModel model;

  const TransactionListTile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      child: Row(
        children: [
          model.operationType == OperationType.cashback
              ? const Icon(
                  Icons.keyboard_double_arrow_up,
                  color: AppColors.kIncomGreenColor,
                )
              : const Icon(
                  Icons.keyboard_double_arrow_down,
                  color: AppColors.kExpenseRedColor,
                ),
          const AddWidth(0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                model.performTransactionOn.name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              CustomText("Amount: ${model.enteredAmount.toString()}"),
            ],
          ),
          // const Spacer(),
          // IconButton(
          //   onPressed: () {
          //     // AppNavigator.pushNamed(
          //     //   AppRoutes.addUpdateIncomeOrExpenseRoute,
          //     //   arguments: IncomeExpenseUpdateArgs(
          //     //     model: incomeExpenseModel,
          //     //   ),
          //     // );
          //   },
          //   icon: const Icon(
          //     Icons.edit,
          //   ),
          // )
        ],
      ),
    );
  }
}
