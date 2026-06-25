import 'package:flutter/material.dart';

import '../../../../core/constants/app_data.dart';
import 'section_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Skills',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: AppData.skills
            .map((skill) => Chip(label: Text(skill)))
            .toList(),
      ),
    );
  }
}
