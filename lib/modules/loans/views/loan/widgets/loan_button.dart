import 'package:flutter/material.dart';

import '../../../../../const/app_sizing.dart';
import '../../../../../widgets/custom/custom_text_widget.dart';

class LoanButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color borderColor;
  const LoanButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.borderColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizing.kHorizontalPadding,
            vertical: AppSizing.kVerticalPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSizing.kDefaultBorderRadius,
          ),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            CustomText(text),
          ],
        ),
      ),
    );
  }
}
