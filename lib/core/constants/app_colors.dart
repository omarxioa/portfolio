import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color(0xFF080808);
  static const Color surface = Color(0xFF111111);
  static const Color surfaceElevated = Color(0xFF1A1A1A);
  /// Structural accent. Non-interactive only: bullets, eyebrows, tags, badges,
  /// decorative glows. Never on something the visitor can click.
  static const Color primary = Color(0xFF6BE3C6);

  static const Color text = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFF9AA7BA);

  /// Action accent. Interactive only: buttons, CTAs, and the active state of a
  /// control. If it is lime, it is clickable.
  static const Color lime = Color(0xFFBCFF00);
}
