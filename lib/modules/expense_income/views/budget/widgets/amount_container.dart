import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep_in_check/extensions.dart';

import '../../../../../const/app_colors.dart';
import '../../../../../const/app_sizing.dart';
import '../../../../../widgets/custom/custom_text_widget.dart';

class AmountContainerWidget extends StatelessWidget {
  final String title;
  final int amount;
  final Color containerColor;
  final String icon;

  const AmountContainerWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.containerColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSizing.kDefaultBorderRadius * 2,
            ),
            color: containerColor,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: AppColors.kTextWhiteColor,
                  borderRadius: BorderRadius.circular(
                    AppSizing.kDefaultBorderRadius * 1.5,
                  ),
                ),
                child: Image.asset(
                  icon,
                  scale: 4,
                ),
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    title,
                    textColor: AppColors.kTextWhiteColor,
                    fontSize: 14,
                  ),
                  CustomText(
                    amount.formatAsDecimals(),
                    textColor: AppColors.kTextWhiteColor,
                    fontSize: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
