import 'package:flutter/material.dart';

import '../../../../core/constants/app_data.dart';
import 'experience_item.dart';
import 'section_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Experience',
      child: Column(
        children: AppData.experiences
            .map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: ExperienceItem(entry: entry),
              ),
            )
            .toList(),
      ),
    );
  }
}
