import 'package:flutter/material.dart';
import 'package:keep_in_check/modules/expense_income/models/income_model.dart';

import '../../../../../widgets/add_height_width.dart';
import 'income_list_tile.dart';
import '../../budget/widgets/total_amount_widget.dart';

class IncomeListViewWidget extends StatelessWidget {
  final List<IncomeModel> incomeList;
  final int totalAmount;
  const IncomeListViewWidget(
      {super.key, required this.incomeList, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddHeight(0.05),
        Align(
          alignment: Alignment.center,
          child: TotalAmountWidget(
            title: "Total Income",
            amount: totalAmount,
          ),
        ),
        const AddHeight(0.05),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const AddHeight(0.02),
            itemCount: incomeList.length,
            itemBuilder: (context, index) {
              return IncomeListTile(
                incomeModel: incomeList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
