import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/project_model.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          project.description,
          style: textTheme.bodyMedium?.copyWith(color: AppColors.secondaryText),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies
              .map(
                (item) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.secondaryText.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    item,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
