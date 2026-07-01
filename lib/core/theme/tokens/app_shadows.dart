import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

abstract final class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(color: Color(0x45000000), blurRadius: 26, offset: Offset(0, 16)),
  ];

  static List<BoxShadow> glow([double alpha = 0.22]) {
    return [
      BoxShadow(
        color: AppColors.primary.withValues(alpha: alpha),
        blurRadius: 36,
        offset: const Offset(0, 12),
      ),
    ];
  }
}
