import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'tokens/app_radius.dart';
import 'tokens/motion.dart';

abstract final class AppTheme {
  /// Headings and UI text.
  static const displayFamily = 'Space Grotesk';

  /// Running prose, which wants the taller x-height.
  static const bodyFamily = 'Manrope';

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        // primary is the structural accent; lime is reserved for actions.
        primary: AppColors.primary,
        secondary: AppColors.lime,
        surface: AppColors.surface,
        onPrimary: AppColors.background,
        onSurface: AppColors.text,
      ),
      textTheme: base.textTheme
          .apply(fontFamily: displayFamily)
          .copyWith(
            bodyLarge: const TextStyle(
              fontFamily: bodyFamily,
              fontSize: 18,
              color: AppColors.text,
              height: 1.55,
            ),
            bodyMedium: const TextStyle(
              fontFamily: bodyFamily,
              fontSize: 16,
              color: AppColors.text,
              height: 1.55,
            ),
          )
          .apply(bodyColor: AppColors.text, displayColor: AppColors.text),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.text,
          side: const BorderSide(color: Colors.white24),
          minimumSize: const Size(150, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
          animationDuration: Motion.fast,
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.surface,
        side: const BorderSide(color: Colors.white24, width: 0.8),
        labelStyle: const TextStyle(color: AppColors.text),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
