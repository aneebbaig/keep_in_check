import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_colors.dart';
import 'package:keep_in_check/const/app_sizing.dart';
import 'package:keep_in_check/widgets/add_height_width.dart';

class YourDataListTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;

  final VoidCallback? onTap;
  final String icon;

  const YourDataListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.kTextGreyColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(
            AppSizing.kDefaultBorderRadius,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizing.kHorizontalPadding,
          vertical: AppSizing.kVerticalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              scale: 4,
            ),
            const AddWidth(0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title,
                  if (subtitle != null) ...[
                    const SizedBox(height: 4.0),
                    subtitle!,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
