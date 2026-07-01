import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import 'tokens/app_radius.dart';
import 'tokens/motion.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primarySoft,
        surface: AppColors.surface,
        onPrimary: AppColors.background,
        onSurface: AppColors.text,
      ),
      textTheme: GoogleFonts.spaceGroteskTextTheme(base.textTheme)
          .copyWith(
            bodyLarge: GoogleFonts.manrope(
              fontSize: 18,
              color: AppColors.text,
              height: 1.55,
            ),
            bodyMedium: GoogleFonts.manrope(
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
