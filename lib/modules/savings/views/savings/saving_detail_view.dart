import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keep_in_check/modules/savings/viewmodel/savings_viewmodel.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/utils/app_utils.dart';
import 'package:keep_in_check/widgets/custom/custom_appbar.dart';
import 'package:keep_in_check/widgets/custom/custom_screen_padding.dart';
import 'package:provider/provider.dart';

import '../../models/savings_model.dart';

class SavingsDetailScreen extends StatelessWidget {
  final List<SavingsModel> savingsList;

  const SavingsDetailScreen({super.key, required this.savingsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Month Summary",
      ),
      body: CustomScreenPadding(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: savingsList.length,
          itemBuilder: (context, index) {
            SavingsModel saving = savingsList[index];
            return ListTile(
              title: Text(
                  'Date: ${DateFormat('dd-MMM-yyyy').format(saving.dateTime)}'),
              subtitle: Text('Amount: \$${saving.savingAmount}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  AppUtils.showProgressDialog();
                  await context
                      .read<SavingsViewModel>()
                      .deleteSaving(saving.id);
                  AppNavigator.pop();
                  AppNavigator.pop();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
