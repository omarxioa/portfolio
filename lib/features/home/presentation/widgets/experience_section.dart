import 'package:flutter/material.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/widgets/layout/app_container.dart';
import '../../../../core/widgets/primitives/app_section.dart';
import '../../../../core/theme/tokens/app_space.dart';
import 'experience_item.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: AppSection(
        title: 'Experience',
        subtitle:
            'Roles where I shipped products and grew engineering quality.',
        surface: true,
        child: Column(
          children: AppData.experiences
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpace.md),
                  child: ExperienceItem(entry: entry),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
