import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/modules/loans/models/loan_model.dart';
import 'package:keep_in_check/modules/loans/viewmodel/loan_viewmodel.dart';
import 'package:keep_in_check/routing/router.dart';
import 'package:keep_in_check/services/field_validations.dart';
import 'package:keep_in_check/utils/app_utils.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_elevated_button.dart';
import 'package:keep_in_check/widgets/custom/custom_screen_padding.dart';
import 'package:keep_in_check/widgets/custom/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class LoanDialog extends StatefulWidget {
  final LoanType type;
  const LoanDialog({super.key, required this.type});

  @override
  State<LoanDialog> createState() => _LoanDialogState();
}

class _LoanDialogState extends State<LoanDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final loanKey = GlobalKey<FormState>();

  PhoneContact? borrower;

  @override
  Widget build(BuildContext context) {
    return CustomScreenPadding(
      child: Form(
        key: loanKey,
        child: Column(
          children: [
            CustomTextFormField(
              hintText: widget.type == LoanType.given
                  ? "Borrower Name"
                  : "Lender Name",
              controller: nameController,
              validator: AppValidators.requiredField,
              prefix: GestureDetector(
                onTap: () async {
                  final contact = await FlutterContactPicker.pickPhoneContact();
                  nameController.text = contact.fullName ?? "";
                  if (contact.phoneNumber != null &&
                      contact.phoneNumber?.number != null) {
                    phoneController.text = contact.phoneNumber!.number!;
                  }
                },
                child: const Icon(
                  Icons.contacts,
                  color: AppColors.kTextGreyColor,
                ),
              ),
            ),
            const AddHeight(0.01),
            CustomTextFormField(
              hintText: widget.type == LoanType.given
                  ? "Borrower Phone Number"
                  : "Lender Phone Number",
              validator: AppValidators.requiredField,
              controller: phoneController,
              keyboardInputType:
                  const TextInputType.numberWithOptions(decimal: false),
            ),
            const AddHeight(0.01),
            CustomTextFormField(
              hintText: "Enter Amount",
              validator: AppValidators.requiredAmountField,
              controller: amountController,
              keyboardInputType:
                  const TextInputType.numberWithOptions(decimal: false),
            ),
            const AddHeight(0.02),
            CustomElevatedButton(
              buttonText: "Done",
              onPressed: () async {
                if (loanKey.currentState!.validate()) {
                  AppUtils.showProgressDialog();
                  await context.read<LoanViewModel>().addALoan(
                        LoanModel(
                          id: "",
                          name: nameController.text,
                          phno: phoneController.text,
                          type: widget.type.name,
                          amount: int.parse(amountController.text),
                          isPaid: false,
                        ),
                      );
                  AppNavigator.pop();
                  AppNavigator.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
