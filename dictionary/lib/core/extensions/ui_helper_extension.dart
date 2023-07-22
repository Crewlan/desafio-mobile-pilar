import 'package:flutter/material.dart';

extension LayoutHelperBuildContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  bool isMobileWidth() {
    return width <= 550 ? true : false;
  }

  bool isMobileHeight() {
    return height <= 550 ? true : false;
  }
}
