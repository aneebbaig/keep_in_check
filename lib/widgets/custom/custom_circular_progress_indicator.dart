import 'package:flutter/material.dart';

import '../../const/app_colors.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.kPrimaryColor,
      ),
    );
  }
}
