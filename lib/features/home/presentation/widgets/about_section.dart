import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import '../../../../core/theme/tokens/app_space.dart';
import '../../../../core/widgets/layout/app_container.dart';
import '../../../../core/widgets/primitives/app_section.dart';
import '../../../../core/widgets/primitives/app_tag.dart';

/// About and stack in one section rather than two.
///
/// The copy and the skill list already existed in [AppData] but were never
/// rendered, so the site stated no position and gave keyword scans nothing to
/// find beyond the per-project chips.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppContainer(
      child: AppSection(
        title: 'About',
        subtitle: AppData.title,
        surface: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                AppData.about,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.text,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: AppSpace.lg),
            ...AppData.notes.map(
              (note) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpace.xs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Icon(
                        Icons.circle,
                        size: 5,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpace.sm),
                    Expanded(
                      child: Text(
                        note,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryText,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpace.lg),
            Text(
              'Stack',
              style: textTheme.labelLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: AppSpace.sm),
            Wrap(
              spacing: AppSpace.xs,
              runSpacing: AppSpace.xs,
              children: AppData.skills
                  .map((skill) => AppTag(label: skill))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
