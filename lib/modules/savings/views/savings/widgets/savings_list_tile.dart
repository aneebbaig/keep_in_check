import 'package:flutter/material.dart';
import 'package:keep_in_check/routing/app_routes.dart';

import '../../../../../routing/router.dart';
import '../../../../../widgets/add_height_width.dart';
import '../../../../../widgets/custom/custom_list_tile.dart';
import '../../../../../widgets/custom/custom_text_widget.dart';
import '../../../models/month_summary_model.dart';

class SavingListTile extends StatelessWidget {
  const SavingListTile({
    super.key,
    required this.summary,
  });

  final MonthSummary summary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushNamed(
          AppRoutes.savingHistoryRoute,
          arguments: summary.savingsList,
        );
      },
      child: CustomListTile(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              summary.monthAndYear,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            const AddHeight(0.005),
            CustomText("PKR Savings: PKR ${summary.totalSavingsPKR}"),
            const AddHeight(0.005),
            CustomText("USD Savings: \$${summary.totalSavingsUSD}"),
          ],
        ),
      ),
    );
  }
}
