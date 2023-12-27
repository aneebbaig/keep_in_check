import 'package:flutter/material.dart';

class AppSpacing {
  static double getHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
}
