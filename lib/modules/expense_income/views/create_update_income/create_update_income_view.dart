import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:keep_in_check/modules/expense_income/models/income_model.dart';
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

class CreateUpdateIncomeView extends StatefulWidget {
  final IncomeModel? model;
  const CreateUpdateIncomeView({super.key, this.model});

  @override
  State<CreateUpdateIncomeView> createState() => _CreateUpdateIncomeViewState();
}

class _CreateUpdateIncomeViewState extends State<CreateUpdateIncomeView> {
  late bool isUpdate;
  IncomeModel? incomeModel;

  String groupValue = "PKR";

  final _incomeCreateUpdateKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime _createdAt = DateTime.now();
  final dateFormat = DateFormat("dd-MMM-yyyy");

  String selectedIncomeType = "Monthly";
  bool isExtra = false;
  List<String> dropDownList = const ['Monthly', 'Extra'];

  void _radioOnChanged(String? value) {
    setState(() {
      groupValue = value!;
    });
  }

  @override
  void initState() {
    super.initState();
    isUpdate = widget.model != null;

    _setControllersOnIsUpdate();
  }

  _setControllersOnIsUpdate() {
    if (isUpdate) {
      incomeModel = widget.model;
      _titleController.text = incomeModel!.name;
      _amountController.text = incomeModel!.amount.toString();
      _createdAt = incomeModel!.createdAt;
      isExtra = incomeModel!.isExtra;
      selectedIncomeType = isExtra ? "Extra" : "Monthly";
      if (incomeModel!.isUSD) {
        groupValue = "USD";
      } else {
        groupValue = "PKR";
      }
    }
    _dateController.text = dateFormat.format(_createdAt);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: isUpdate ? "Update Income" : "Add Income",
      ),
      body: CustomScreenPadding(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _incomeCreateUpdateKey,
                  child: Column(
                    children: [
                      CustomDropdown(
                        items: dropDownList,
                        hintText: "Type of Income",
                        label: "Income Type",
                        onChanged: (value) {
                          setState(() {
                            selectedIncomeType = value!;
                            if (selectedIncomeType == "Extra") {
                              isExtra = true;
                            } else {
                              isExtra = false;
                            }
                          });
                        },
                        value: selectedIncomeType,
                      ),
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
                      const AddHeight(0.02),
                      CustomTextFormField(
                        controller: _amountController,
                        label: "Amount",
                        hintText: "Enter Earned Amount",
                        validator: AppValidators.requiredAmountField,
                        prefix: Container(
                          alignment: Alignment.center,
                          width: 0.1.sw,
                          child: CustomText(groupValue),
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
              buttonText: isUpdate ? "Update Income" : "Add Income",
              onPressed: () {
                if (_incomeCreateUpdateKey.currentState!.validate()) {
                  if (isUpdate) {
                    context.read<IncomeExpenseViewModel>().updateIncomeList(
                          id: incomeModel!.id,
                          name: _titleController.text,
                          amount: int.parse(_amountController.text),
                          isUSD: groupValue == "USD",
                          createdAt: _createdAt,
                          isExtra: isExtra,
                        );
                  } else {
                    context.read<IncomeExpenseViewModel>().addToIncomeList(
                          name: _titleController.text,
                          amount: int.parse(_amountController.text),
                          isUSD: groupValue == "USD",
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
