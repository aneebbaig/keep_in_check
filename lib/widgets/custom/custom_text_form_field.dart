import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';
import 'package:keep_in_check/widgets/custom/custom_text_widget.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText, label;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardInputType;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final Color cursorColor;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Color? borderColor;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.onChanged,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardInputType = TextInputType.text,
    this.suffix,
    this.inputFormatters,
    this.cursorColor = AppColors.kPrimaryColor,
    this.enabled = true,
    this.onTap,
    this.readOnly = false,
    this.prefix,
    this.borderColor,
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
        TextFormField(
          validator: validator,
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          cursorColor: cursorColor,
          keyboardType: keyboardInputType,
          inputFormatters: inputFormatters,
          enabled: enabled,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            border: borderColor != null
                ? Theme.of(context).inputDecorationTheme.border!.copyWith(
                      borderSide: BorderSide(color: borderColor!),
                    )
                : null,
            disabledBorder: borderColor != null
                ? Theme.of(context).inputDecorationTheme.border!.copyWith(
                      borderSide: BorderSide(color: borderColor!),
                    )
                : null,
            enabledBorder: borderColor != null
                ? Theme.of(context).inputDecorationTheme.border!.copyWith(
                      borderSide: BorderSide(color: borderColor!),
                    )
                : null,
            //prefix: prefix,
            prefixIcon: prefix,
            hintText: hintText,
            suffix: suffix,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintFadeDuration: const Duration(
              milliseconds: 500,
            ),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
