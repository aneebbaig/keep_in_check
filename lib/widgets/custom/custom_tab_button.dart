import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/app_colors.dart';
import 'custom_text_widget.dart';

class CustomTabButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String buttonText;
  const CustomTabButton(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 0.06.sh,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kPrimaryColor
              : AppColors.kTransparentColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.kPrimaryColor,
          ),
        ),
        child: CustomText(
          buttonText,
          textAlign: TextAlign.center,
          textColor:
              isSelected ? AppColors.kTextWhiteColor : AppColors.kPrimaryColor,
        ),
      ),
    );
  }
}
