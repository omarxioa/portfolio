import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class StatPill extends StatelessWidget {
  const StatPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.secondaryText.withValues(alpha: 0.35),
        ),
      ),
      child: Text(
        label,
        style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryText),
      ),
    );
  }
}
