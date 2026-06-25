import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ContactChip extends StatelessWidget {
  const ContactChip({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: AppColors.background,
      side: const BorderSide(color: AppColors.primary),
      labelStyle: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: AppColors.text),
    );
  }
}
