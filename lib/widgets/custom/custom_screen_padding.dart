import 'package:flutter/material.dart';
import 'package:keep_in_check/const/app_sizing.dart';

class CustomScreenPadding extends StatelessWidget {
  final Widget child;
  final double? horizontalPadding;
  final double? verticalPadding;

  const CustomScreenPadding(
      {super.key,
      required this.child,
      this.horizontalPadding,
      this.verticalPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? AppSizing.kHorizontalPadding,
        vertical: verticalPadding ?? AppSizing.kVerticalPadding,
      ),
      child: child,
    );
  }
}
