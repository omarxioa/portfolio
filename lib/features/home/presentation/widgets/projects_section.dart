import 'package:flutter/material.dart';

import '../../../../core/constants/app_data.dart';
import 'project_item.dart';
import 'section_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Featured Projects',
      child: Column(
        children: AppData.projects
            .map(
              (project) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: ProjectItem(project: project),
              ),
            )
            .toList(),
      ),
    );
  }
}
