import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        child: Text(
          '© ${DateTime.now().year} ${AppData.name}. All rights reserved.',
          style: textTheme.bodySmall?.copyWith(color: AppColors.secondaryText),
        ),
      ),
    );
  }
}
