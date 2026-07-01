import 'package:flutter/material.dart';

import '../../../../core/widgets/layout/app_container.dart';
import '../../../../core/widgets/primitives/app_section.dart';
import '../../../../core/widgets/primitives/app_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: AppSection(
        title: 'About',
        subtitle: 'A quick snapshot of how I approach product engineering.',
        surface: true,
        child: const AppSubtitle(
          text:
              'I help teams turn product ideas into reliable Flutter apps that scale from MVP to enterprise. I focus on pragmatic architecture, clean UX, and fast shipping without quality debt. I work closely with design and backend teams so each release feels polished and measurable.',
          maxWidth: 900,
        ),
      ),
    );
  }
}
