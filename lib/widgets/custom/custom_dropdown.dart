import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/const/app_sizing.dart';

import '../add_height_width.dart';
import 'custom_text_widget.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final String? label;
  final String value;

  const CustomDropdown({
    super.key,
    required this.items,
    this.onChanged,
    this.validator,
    required this.hintText,
    this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          CustomText(
            label!,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          const AddHeight(0.005),
        ],
        DropdownButtonFormField2<String>(
          value: value,
          isExpanded: false,
          isDense: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSizing.kDefaultBorderRadius),
            ),
          ),
          hint: Text(
            hintText,
            style: const TextStyle(fontSize: 14),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              )
              .toList(),
          validator: validator,
          onChanged: onChanged,
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: AppColors.kTextWhiteColor,
              borderRadius:
                  BorderRadius.circular(AppSizing.kDefaultBorderRadius),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizing.kHorizontalFormFieldPadding,
            ),
          ),
        ),
      ],
    );
  }
}
