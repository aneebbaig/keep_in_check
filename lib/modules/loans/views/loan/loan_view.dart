import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/extensions.dart';
import 'package:keep_in_check/modules/loans/models/loan_model.dart';
import 'package:keep_in_check/modules/loans/viewmodel/loan_viewmodel.dart';
import 'package:keep_in_check/routing/app_routes.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/utils/app_utils.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_appbar.dart';
import 'package:keep_in_check/widgets/custom/custom_screen_padding.dart';
import 'package:keep_in_check/widgets/custom/custom_text_widget.dart';
import 'package:keep_in_check/widgets/dialogs/loan_dialog.dart';
import 'package:provider/provider.dart';

import 'widgets/loan_button.dart';
import 'widgets/loan_list_tile.dart';

class LoanView extends StatefulWidget {
  const LoanView({super.key});

  @override
  State<LoanView> createState() => _LoanViewState();
}

class _LoanViewState extends State<LoanView> {
  @override
  void initState() {
    super.initState();

    _fetchLoans();
  }

  _fetchLoans() {
    context.read<LoanViewModel>().getAllLoans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Loan Management",
      ),
      body: CustomScreenPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoanButtonWidget(
                  text: 'Give Loan',
                  onTap: () {
                    AppUtils.showDialogWithContent(
                      context: context,
                      heading: "Loan Amount",
                      dialog: const LoanDialog(
                        type: LoanType.given,
                      ),
                      barrierDismissable: true,
                    );
                  },
                  borderColor: AppColors.kIncomGreenColor,
                  icon: Icons.keyboard_arrow_right,
                ),
                const AddWidth(0.05),
                LoanButtonWidget(
                  text: 'Take Loan',
                  onTap: () {
                    AppUtils.showDialogWithContent(
                      context: context,
                      heading: "Loan Amount",
                      dialog: const LoanDialog(
                        type: LoanType.taken,
                      ),
                      barrierDismissable: true,
                    );
                  },
                  borderColor: AppColors.kExpenseRedColor,
                  icon: Icons.keyboard_arrow_right,
                ),
              ],
            ),
            const AddHeight(0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Loan History".asHeading(context),
                InkWell(
                  onTap: () {
                    AppNavigator.pushNamed(AppRoutes.loansHistoryRoute);
                  },
                  child: const CustomText(
                    "Loans Paid",
                    textColor: AppColors.kPrimaryColor,
                    isUnderlined: true,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const AddHeight(0.015),
            Expanded(
              child: Consumer<LoanViewModel>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          FilterButton(
                            buttonTitle: "Given",
                            isSelected:
                                provider.selectedLoanType == LoanType.given,
                            onTap: () {
                              provider.setSelectedLoanType(LoanType.given);
                            },
                          ),
                          const AddWidth(0.02),
                          FilterButton(
                            buttonTitle: "Taken",
                            isSelected:
                                provider.selectedLoanType == LoanType.taken,
                            onTap: () {
                              provider.setSelectedLoanType(LoanType.taken);
                            },
                          ),
                        ],
                      ),
                      const AddHeight(0.03),
                      Expanded(
                        child: Builder(builder: (context) {
                          if (provider.selectedLoanList.isEmpty) {
                            return const Center(
                              child: CustomText("No Loans Found"),
                            );
                          }
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const AddHeight(0.015),
                            itemCount: provider.selectedLoanList.length,
                            itemBuilder: (context, index) {
                              LoanModel loan = provider.selectedLoanList[index];
                              return LoanListTile(loan: loan);
                            },
                          );
                        }),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final bool isSelected;
  final String buttonTitle;
  final VoidCallback onTap;
  const FilterButton({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kPrimaryColor
              : AppColors.kTransparentColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.kPrimaryColor),
        ),
        child: CustomText(
          buttonTitle,
          style: TextStyle(
            fontSize: 12,
            color: isSelected
                ? AppColors.kTextWhiteColor
                : AppColors.kTextBlackColor,
          ),
        ),
      ),
    );
  }
}
