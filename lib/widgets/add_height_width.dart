import 'package:flutter/material.dart';
import 'package:keep_in_check/services/app_spacing.dart';

class AddHeight extends StatelessWidget {
  final double percentage;
  const AddHeight(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = AppSpacing.getHeight(context);
    return SizedBox(
      height: height * percentage,
    );
  }
}

class AddWidth extends StatelessWidget {
  final double percentage;
  const AddWidth(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = AppSpacing.getWidth(context);
    return SizedBox(
      width: width * percentage,
    );
  }
}
