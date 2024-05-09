import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep_in_check/const/app_sizing.dart';
import 'package:keep_in_check/extensions.dart';
import 'package:keep_in_check/modules/expense_income/views/budget/widgets/total_amount_widget.dart';
import 'package:keep_in_check/modules/savings/viewmodel/savings_viewmodel.dart';
import 'package:keep_in_check/utils/app_utils.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_appbar.dart';
import 'package:keep_in_check/widgets/custom/custom_circular_progress.dart';
import 'package:keep_in_check/widgets/custom/custom_screen_padding.dart';
import 'package:keep_in_check/widgets/custom/custom_text_widget.dart';
import 'package:keep_in_check/widgets/dialogs/add_saving_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../const/app_colors.dart';
import '../../models/month_summary_model.dart';
import 'widgets/savings_list_tile.dart';

class SavingsView extends StatefulWidget {
  const SavingsView({super.key});

  @override
  State<SavingsView> createState() => _SavingsViewState();
}

class _SavingsViewState extends State<SavingsView> {
  bool showFilter = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchSavings();
  }

  void _fetchSavings() async {
    context.read<SavingsViewModel>().setIsLoading(true, notify: false);
    await context.read<SavingsViewModel>().getAllSavings();

    if (context.mounted) {
      context.read<SavingsViewModel>().setIsLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Savings",
        actions: [
          IconButton(
            onPressed: () {
              AppUtils.showDialogWithContent(
                  context: context,
                  heading: "Add a Saving",
                  dialog: const AddSavingDialog(),
                  barrierDismissable: false);
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ],
      ),
      body: CustomScreenPadding(
        child: Consumer<SavingsViewModel>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const CustomCircularProgressIndicator();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TotalAmountWidget(
                      title: "PKR Savings",
                      amount: provider.totalPKRSavings,
                    ),
                    const AddWidth(0.05),
                    TotalAmountWidget(
                      title: "USD Savings",
                      amount: provider.totalUSDSavings,
                    ),
                  ],
                ),
                const AddHeight(0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Monthly Savings".asHeading(context),
                    GestureDetector(
                      onTap: () {
                        AppUtils.showDialogWithContent(
                          context: context,
                          heading: "Select Year",
                          dialog: YearPickerDialog(
                            selectedDate: _selectedDate,
                            onChanged: (date) async {
                              setState(() {
                                _selectedDate = date;
                              });
                              context
                                  .read<SavingsViewModel>()
                                  .setIsLoading(true);
                              await context
                                  .read<SavingsViewModel>()
                                  .getAllSavings(date: _selectedDate);
                              if (context.mounted) {
                                context
                                    .read<SavingsViewModel>()
                                    .setIsLoading(false);
                              }
                            },
                          ),
                          barrierDismissable: false,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSizing.kDefaultBorderRadius,
                          ),
                          border: Border.all(
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        child: CustomText(
                          _selectedDate.year.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                // if (showFilter) ...[
                //   const AddHeight(0.01),
                //   YearPickerWidget(selectedDate: _selectedDate),
                // ],
                Expanded(
                  child: Builder(builder: (context) {
                    if (provider.savingsList.isEmpty) {
                      return const Center(
                        child: CustomText("No Savings Found"),
                      );
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const AddHeight(0.015),
                      itemCount: provider.monthSummaries.length,
                      itemBuilder: (context, index) {
                        MonthSummary summary = provider.monthSummaries[index];
                        if (summary.savingsList.isEmpty) {
                          return const SizedBox();
                        }
                        return SavingListTile(summary: summary);
                      },
                    );
                  }),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class YearPickerDialog extends StatefulWidget {
  const YearPickerDialog({
    super.key,
    required DateTime selectedDate,
    required this.onChanged,
  }) : _selectedDate = selectedDate;

  final DateTime _selectedDate;
  final Function(DateTime) onChanged;

  @override
  State<YearPickerDialog> createState() => _YearPickerDialogState();
}

class _YearPickerDialogState extends State<YearPickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizing.kDefaultBorderRadius),
      ),
      width: 0.8.sw,
      height: 0.5.sh,
      child: YearPicker(
          firstDate: DateTime(2000),
          lastDate: DateTime(DateTime.now().year),
          selectedDate: widget._selectedDate,
          onChanged: (date) {
            widget.onChanged(date);
            Navigator.pop(context);
          }),
    );
  }
}
