import 'package:flutter/material.dart';

extension ScreenSizerExtension on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  double get width => mediaQueryData.size.width;
  double get height => mediaQueryData.size.height;
  Orientation get orientation => mediaQueryData.orientation;

  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  bool isWebOrDesktopSize() => width >= 1000; // the default size is 950

  bool isTabletSize() => width >= 600;

  bool isPassedMinHeight() => height > 500;

  bool isPassedMinSizeForWeb() => isWebOrDesktopSize() && isPassedMinHeight();
}
