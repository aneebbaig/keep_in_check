import 'package:flutter/material.dart';

class ScreenPadding extends StatelessWidget {
  final Widget child;
  final double topPadding;
  const ScreenPadding({super.key, required this.child, this.topPadding = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: topPadding,
      ),
      child: child,
    );
  }
}
