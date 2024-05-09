import 'package:flutter/material.dart';

import '../custom/custom_circular_progress.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: CustomCircularProgressIndicator(),
    );
  }
}
