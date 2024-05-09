import 'package:flutter/material.dart';

import '../../const/app_colors.dart';
import 'custom_text_widget.dart';

class ExtraTagWidget extends StatelessWidget {
  const ExtraTagWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryAccentColor,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      alignment: Alignment.center,
      child: const CustomText(
        "Extra",
        textColor: AppColors.kTextWhiteColor,
        fontSize: 10,
      ),
    );
  }
}
