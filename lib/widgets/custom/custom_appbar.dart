import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color backgroundColor;
  final Color titleColor;
  final Widget? leading;
  final List<Widget>? actions;
  final bool canBePopped;

  const CustomAppBar({
    super.key,
    this.title,
    this.backgroundColor = AppColors.kTransparentColor,
    this.titleColor = AppColors.kTextGreyColor,
    this.leading,
    this.actions,
    this.canBePopped = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: canBePopped,
      backgroundColor: backgroundColor,
      title: title == null
          ? null
          : Text(
              title!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
