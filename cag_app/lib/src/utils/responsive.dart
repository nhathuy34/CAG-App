import 'package:flutter/widgets.dart';

enum DeviceSize { small, normal, large }

class Responsive {
  // Breakpoints in logical pixels
  static const double smallMaxWidth = 360;
  static const double normalMaxWidth = 430;

  static DeviceSize deviceSize(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w <= smallMaxWidth) return DeviceSize.small;
    if (w <= normalMaxWidth) return DeviceSize.normal;
    return DeviceSize.large;
  }

  // Width percent of the screen
  static double widthPercent(BuildContext context, double percent) {
    final w = MediaQuery.of(context).size.width;
    return w * (percent / 100.0);
  }

  // Height percent of the screen
  static double heightPercent(BuildContext context, double percent) {
    final h = MediaQuery.of(context).size.height;
    return h * (percent / 100.0);
  }

  // Scales a base font size according to device size and system textScaleFactor
  static double fontSize(BuildContext context, double base) {
    final ds = deviceSize(context);
    double scaled = base;
    switch (ds) {
      case DeviceSize.small:
        scaled = base * 0.92;
        break;
      case DeviceSize.normal:
        scaled = base;
        break;
      case DeviceSize.large:
        scaled = base * 1.06;
        break;
    }
    // Respect system text scale
    return scaled * MediaQuery.of(context).textScaleFactor;
  }

  static bool isSmall(BuildContext context) => deviceSize(context) == DeviceSize.small;
  static bool isNormal(BuildContext context) => deviceSize(context) == DeviceSize.normal;
  static bool isLarge(BuildContext context) => deviceSize(context) == DeviceSize.large;
}
