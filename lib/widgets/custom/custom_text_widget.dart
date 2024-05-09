import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String data;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool isUnderlined;

  const CustomText(
    this.data, {
    super.key,
    this.textColor,
    this.fontWeight,
    this.style,
    this.fontSize,
    this.textAlign,
    this.isUnderlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: style ??
          Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
                decoration: isUnderlined ? TextDecoration.underline : null,
              ),
    );
  }
}
