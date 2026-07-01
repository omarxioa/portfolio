import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    this.size = 28,
    this.highlight = false,
    this.label = 'O',
  });

  final double size;
  final bool highlight;
  final String label;

  @override
  Widget build(BuildContext context) {
    final borderColor = highlight
        ? AppColors.primary.withValues(alpha: 0.48)
        : Colors.white.withValues(alpha: 0.14);
    final backgroundColor = highlight
        ? AppColors.primary.withValues(alpha: 0.14)
        : Colors.white.withValues(alpha: 0.04);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: highlight ? AppColors.primary : AppColors.text,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}
