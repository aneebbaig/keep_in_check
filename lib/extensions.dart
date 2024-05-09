import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets/custom/custom_text_widget.dart';

extension IntExtensions on int {
  String formatAsDecimals() {
    final formatter = NumberFormat('#,###,##0');
    return formatter.format(this);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension Heading on String {
  Widget asHeading(BuildContext context,
      {FontWeight fontWeight = FontWeight.w700}) {
    return CustomText(
      this,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(fontWeight: fontWeight),
    );
  }
}
