import 'package:flutter/material.dart';

extension ResponsiveSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double get responsiveScale {
    final scale = screenWidth / 375.0;
    return scale.clamp(0.8, 1.3) as double;
  }

  double wp(double percent) => screenWidth * percent / 100;
  double hp(double percent) => screenHeight * percent / 100;
  double sp(double fontSize) => fontSize * responsiveScale;
}
