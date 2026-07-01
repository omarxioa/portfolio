import 'package:flutter/material.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/theme/tokens/app_space.dart';
import '../../../../core/widgets/layout/app_container.dart';
import '../../../../core/widgets/primitives/app_section.dart';
import '../../../../core/widgets/primitives/app_tag.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: AppSection(
        title: 'Tech Stack',
        subtitle: 'Tools and systems I rely on to ship stable mobile products.',
        surface: true,
        child: Wrap(
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: AppData.skills
              .map((skill) => AppTag(label: skill))
              .toList(),
        ),
      ),
    );
  }
}
