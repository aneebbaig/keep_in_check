import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/services/app_spacing.dart';
import 'package:keep_in_check/widgets/custom/custom_text_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.color = AppColors.kPrimaryColor,
    this.textColor = Colors.white,
    this.borderRadius = 8,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width ?? AppSpacing.getWidth(context),
        height: height ?? AppSpacing.getHeight(context) * 0.05,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: CustomText(
          buttonText,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor,
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}
