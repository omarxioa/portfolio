import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import 'section_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SectionCard(
      title: 'About Me',
      child: Text(
        AppData.about,
        style: textTheme.bodyLarge?.copyWith(
          color: AppColors.secondaryText,
          height: 1.6,
        ),
      ),
    );
  }
}
