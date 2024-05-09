import 'package:flutter/material.dart';
import 'package:keep_in_check/extensions.dart';

import '../../../../../widgets/add_height_width.dart';
import '../../../../../widgets/custom/custom_text_widget.dart';

class TotalAmountWidget extends StatelessWidget {
  final String title;
  final int amount;
  const TotalAmountWidget({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            title,
            textAlign: TextAlign.center,
          ),
          const AddHeight(0.005),
          Text.rich(
            TextSpan(
              text: amount.formatAsDecimals().toString(),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}
