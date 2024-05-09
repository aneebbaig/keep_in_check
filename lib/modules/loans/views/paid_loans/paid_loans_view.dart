import 'package:flutter/material.dart';
import 'package:keep_in_check/modules/loans/viewmodel/loan_viewmodel.dart';
import 'package:keep_in_check/modules/loans/views/loan/widgets/loan_list_tile.dart';
import 'package:keep_in_check/widgets/custom/custom_appbar.dart';
import 'package:keep_in_check/widgets/custom/custom_circular_progress.dart';
import 'package:keep_in_check/widgets/custom/custom_screen_padding.dart';
import 'package:keep_in_check/widgets/custom/custom_text_widget.dart';
import 'package:provider/provider.dart';

class LoansHistoryView extends StatefulWidget {
  const LoansHistoryView({super.key});

  @override
  State<LoansHistoryView> createState() => _LoansHistoryViewState();
}

class _LoansHistoryViewState extends State<LoansHistoryView> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchPaidLoans();
  }

  _fetchPaidLoans() async {
    await context.read<LoanViewModel>().getPaidLoans();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Loans History",
      ),
      body: CustomScreenPadding(
        child: Consumer<LoanViewModel>(builder: (context, provider, _) {
          if (isLoading == true) {
            return const CustomCircularProgressIndicator();
          }
          if (provider.paidLoans.isEmpty) {
            return const Center(
              child: CustomText("No Loan History"),
            );
          }
          return ListView.builder(
            itemCount: provider.paidLoans.length,
            itemBuilder: (context, index) {
              final loan = provider.paidLoans[index];
              return LoanListTile(loan: loan);
            },
          );
        }),
      ),
    );
  }
}
