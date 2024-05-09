import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:keep_in_check/modules/expense_income/models/expense_model.dart';

import 'package:keep_in_check/modules/expense_income/viewmodel/income_expense_viewmodel.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_appbar.dart';
import 'package:keep_in_check/widgets/custom/custom_dropdown.dart';
import 'package:keep_in_check/widgets/custom/custom_elevated_button.dart';
import 'package:keep_in_check/widgets/custom/custom_screen_padding.dart';
import 'package:keep_in_check/widgets/custom/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../../../routing/router.dart';
import '../../../../services/field_validations.dart';
import '../../../../utils/app_utils.dart';
import '../../../../widgets/custom/custom_text_widget.dart';

class CreateUpdateExpenseView extends StatefulWidget {
  final ExpenseModel? model;
  const CreateUpdateExpenseView({
    super.key,
    this.model,
  });

  @override
  State<CreateUpdateExpenseView> createState() =>
      _CreateUpdateExpenseViewState();
}

class _CreateUpdateExpenseViewState extends State<CreateUpdateExpenseView> {
  late bool isUpdate;
  ExpenseModel? expenseModel;
  int spentBudget = 0;

  final _expenseCreateUpdateKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _budgetController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime _createdAt = DateTime.now();
  final dateFormat = DateFormat("dd-MMM-yyyy");

  String selectedExpenseType = "Monthly";
  bool isExtra = false;
  List<String> dropDownList = const ['Monthly', 'Extra'];

  @override
  void initState() {
    super.initState();
    isUpdate = widget.model != null;
    _setControllersOnIsUpdate();
  }

  _setControllersOnIsUpdate() {
    if (isUpdate) {
      expenseModel = widget.model;
      _titleController.text = expenseModel!.name;
      _budgetController.text = expenseModel!.budget.toString();
      _createdAt = expenseModel!.createdAt;
      isExtra = expenseModel!.isExtra;
      selectedExpenseType = isExtra ? "Extra" : "Monthly";
      spentBudget = expenseModel!.spentBudget;
    }
    _dateController.text = dateFormat.format(_createdAt);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _budgetController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: isUpdate ? "Update Expense" : "Add Expense",
      ),
      body: CustomScreenPadding(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _expenseCreateUpdateKey,
                  child: Column(
                    children: [
                      CustomDropdown(
                        items: dropDownList,
                        hintText: "Select type of Expense",
                        label: "Expense Type",
                        onChanged: (value) {
                          setState(() {
                            selectedExpenseType = value!;
                            if (value == "Extra") {
                              isExtra = true;
                            } else {
                              isExtra = false;
                            }
                          });
                        },
                        value: selectedExpenseType,
                      ),
                      const AddHeight(0.02),
                      CustomTextFormField(
                        controller: _dateController,
                        label: "Date",
                        hintText: "Pick a date",
                        readOnly: true,
                        validator: AppValidators.requiredField,
                        onTap: () {
                          AppUtils.showAppDatePicker(
                            context: context,
                            onDateSelected: (date) {
                              _createdAt = date;
                              String formattedDate = dateFormat.format(date);
                              setState(
                                () {
                                  _dateController.text = formattedDate;
                                },
                              );
                            },
                          );
                        },
                      ),
                      const AddHeight(0.02),
                      CustomTextFormField(
                        controller: _titleController,
                        label: "Title",
                        hintText: "Enter Source Name",
                        validator: AppValidators.requiredField,
                      ),
                      const AddHeight(0.02),
                      CustomTextFormField(
                        controller: _budgetController,
                        label: isExtra ? "Spent Amount" : "Budget",
                        hintText:
                            isExtra ? "Enter Spent Amount" : "Enter a Budget",
                        validator: AppValidators.requiredAmountField,
                        prefix: Container(
                          alignment: Alignment.center,
                          width: 0.1.sw,
                          child: const CustomText("PKR"),
                        ),
                        keyboardInputType:
                            const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomElevatedButton(
              buttonText: isUpdate ? "Update Expense" : "Add Expense",
              onPressed: () {
                if (_expenseCreateUpdateKey.currentState!.validate()) {
                  if (isUpdate) {
                    context.read<IncomeExpenseViewModel>().updateExpenseList(
                          id: expenseModel!.id,
                          name: _titleController.text,
                          amount: int.parse(_budgetController.text),
                          createdAt: _createdAt,
                          isExtra: isExtra,
                          spentBudget: spentBudget,
                        );
                  } else {
                    context.read<IncomeExpenseViewModel>().addToExpenseList(
                          name: _titleController.text,
                          budget: int.parse(_budgetController.text),
                          createdAt: _createdAt,
                          isExtra: isExtra,
                        );
                  }
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
