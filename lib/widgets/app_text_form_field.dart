import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText, label;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardInputType;
  final Widget? suffix;

  const AppTextFormField({
    super.key,
    required this.hintText,
    required this.label,
    this.onChanged,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardInputType = TextInputType.text,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
        ),
        TextFormField(
          validator: validator,
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardInputType,
          decoration: InputDecoration(
            hintText: hintText,
            suffix: suffix,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintFadeDuration: const Duration(
              milliseconds: 500,
            ),
          ),
        ),
      ],
    );
  }
}
