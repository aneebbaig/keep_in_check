import 'package:flutter/material.dart';
import 'package:keep_in_check/modules/transactions/viewmodel/transaction_viewmodel.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_appbar.dart';
import 'package:keep_in_check/widgets/custom/custom_circular_progress.dart';

import 'package:keep_in_check/widgets/custom/custom_screen_padding.dart';
import 'package:keep_in_check/widgets/custom/custom_text_widget.dart';
import 'package:provider/provider.dart';

import '../../../../routing/router.dart';
import 'widgets/transaction_list_tile_widget.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  @override
  void initState() {
    _fetchAllTransactions();
    super.initState();
  }

  _fetchAllTransactions() async {
    context.read<TransactionViewmodel>().setIsLoading(true, notify: false);
    await context.read<TransactionViewmodel>().getAllTransactions();
    AppNavigator.navigatorKey.currentContext!
        .read<TransactionViewmodel>()
        .setIsLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Transactions",
      ),
      body: CustomScreenPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<TransactionViewmodel>(
                  builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const CustomCircularProgressIndicator();
                }

                if (provider.transactionsList.isEmpty) {
                  return const Center(
                    child: CustomText("No Transactions"),
                  );
                }

                return ListView.separated(
                  separatorBuilder: (context, index) => const AddHeight(0.02),
                  itemCount: provider.transactionsList.length,
                  itemBuilder: (context, i) {
                    return TransactionListTile(
                      model: provider.transactionsList[i],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
