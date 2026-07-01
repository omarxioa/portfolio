import 'package:flutter/animation.dart';

abstract final class Motion {
  static const Duration quick = Duration(milliseconds: 160);
  static const Duration fast = Duration(milliseconds: 240);
  static const Duration normal = Duration(milliseconds: 320);
  static const Duration slow = Duration(milliseconds: 520);
  static const Duration heroWordSwitch = Duration(milliseconds: 420);

  static const Curve emphasized = Curves.easeOutCubic;
  static const Curve standard = Curves.easeInOutCubic;
  static const Curve linear = Curves.linear;
}
