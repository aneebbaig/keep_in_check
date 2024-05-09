import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:keep_in_check/extensions.dart';
import 'package:keep_in_check/modules/expense_income/viewmodel/income_expense_viewmodel.dart';
import 'package:keep_in_check/routing/app_routes.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/widgets/custom/custom_list_tile.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_utils.dart';
import '../../../../../widgets/add_height_width.dart';
import '../../../../../widgets/custom/custom_tag_widget.dart';
import '../../../../../widgets/custom/custom_text_widget.dart';
import '../../../models/income_model.dart';

class IncomeListTile extends StatelessWidget {
  final IncomeModel incomeModel;

  const IncomeListTile({
    super.key,
    required this.incomeModel,
  });

  @override
  Widget build(BuildContext context) {
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
                  .deleteIncome(incomeModel.id);
              AppNavigator.pop();
            },
            // backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.black,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: CustomListTile(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (incomeModel.isExtra) ...[
                  const ExtraTagWidget(),
                  const AddHeight(0.01),
                ],
                CustomText(
                  incomeModel.name,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const AddHeight(0.01),
                Row(
                  children: [
                    CustomText(
                      incomeModel.isUSD ? "\$" : "PKR ",
                    ),
                    CustomText(
                      incomeModel.amount.formatAsDecimals().toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (incomeModel.convertedAmount != null)
                      CustomText(
                        " ~ PKR ${incomeModel.convertedAmount!.formatAsDecimals().toString()}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              onPressed: () {
                AppNavigator.pushNamed(
                  AppRoutes.createUpdateIncomeRoute,
                  arguments: incomeModel,
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
