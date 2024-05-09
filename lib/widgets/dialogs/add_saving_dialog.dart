import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:keep_in_check/modules/savings/models/savings_model.dart';
import 'package:keep_in_check/modules/savings/viewmodel/savings_viewmodel.dart';

import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/services/field_validations.dart';
import 'package:keep_in_check/utils/app_utils.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_elevated_button.dart';
import 'package:keep_in_check/widgets/custom/custom_screen_padding.dart';
import 'package:keep_in_check/widgets/custom/custom_text_form_field.dart';
import 'package:keep_in_check/widgets/custom/custom_text_widget.dart';
import 'package:provider/provider.dart';

class AddSavingDialog extends StatefulWidget {
  const AddSavingDialog({super.key});

  @override
  State<AddSavingDialog> createState() => _AddSavingDialogState();
}

class _AddSavingDialogState extends State<AddSavingDialog> {
  final GlobalKey<FormState> _addIncomeFormKey = GlobalKey<FormState>();

  ///////////////////////
  TextEditingController amountController = TextEditingController();
  TextEditingController monthYearController = TextEditingController();

  ///////////////
  String groupValue = "PKR";
  final dateFormat = DateFormat("dd-MMM-yyyy");

  late DateTime selectedDate;

  void _radioOnChanged(String? value) {
    setState(() {
      groupValue = value!;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    monthYearController.text = dateFormat.format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
      child: Form(
        key: _addIncomeFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              controller: monthYearController,
              hintText: "Select date",
              readOnly: true,
              onTap: () {
                AppUtils.showAppDatePicker(
                  context: context,
                  onDateSelected: (date) {
                    selectedDate = date;
                    setState(() {
                      monthYearController.text = dateFormat.format(date);
                    });
                  },
                );
              },
              validator: AppValidators.requiredField,
            ),
            const AddHeight(0.02),
            const CustomText(
              "Select Currency",
            ),
            const AddHeight(0.01),
            Row(
              children: [
                RadioMenuButton(
                  value: "PKR",
                  groupValue: groupValue,
                  onChanged: _radioOnChanged,
                  child: const CustomText("PKR"),
                ),
                RadioMenuButton(
                  value: "USD",
                  groupValue: groupValue,
                  onChanged: _radioOnChanged,
                  child: const CustomText("USD"),
                )
              ],
            ),
            CustomTextFormField(
              controller: amountController,
              hintText: "Enter Saving Amount",
              keyboardInputType: TextInputType.number,
              validator: AppValidators.requiredField,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const AddHeight(0.03),
            CustomElevatedButton(
              buttonText: "Add Saving",
              onPressed: () async {
                if (_addIncomeFormKey.currentState!.validate()) {
                  AppUtils.showProgressDialog();
                  await context.read<SavingsViewModel>().addSaving(
                        SavingsModel(
                          id: '',
                          dateTime: selectedDate,
                          savingAmount: int.parse(amountController.text),
                          isUSD: groupValue == "USD" ? true : false,
                        ),
                      );
                  if (context.mounted) {
                    await context.read<SavingsViewModel>().getAllSavings();
                  }

                  AppNavigator.pop();
                  AppNavigator.pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
