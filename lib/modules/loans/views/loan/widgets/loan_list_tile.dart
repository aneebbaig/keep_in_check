import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/extensions.dart';
import 'package:keep_in_check/modules/loans/viewmodel/loan_viewmodel.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/utils/app_utils.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/custom/custom_list_tile.dart';
import '../../../../../widgets/custom/custom_text_widget.dart';
import '../../../models/loan_model.dart';

class LoanListTile extends StatelessWidget {
  const LoanListTile({
    super.key,
    required this.loan,
  });

  final LoanModel loan;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                loan.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              CustomText(loan.phno),
              CustomText(
                loan.amount.formatAsDecimals(),
              ),
              if (loan.isPaid)
                CustomText(
                  loan.type.capitalize(),
                ),
            ],
          ),
          InkWell(
            onTap: () async {
              AppUtils.showProgressDialog();
              await context.read<LoanViewModel>().markAsPaidUnpaid(loan);
              AppNavigator.pop();
            },
            child: CustomText(
              loan.isPaid ? "Mark As Unpaid" : "Mark As Paid",
              textColor: AppColors.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
