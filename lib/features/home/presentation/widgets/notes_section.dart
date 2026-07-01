import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import '../../../../core/theme/tokens/app_radius.dart';
import '../../../../core/theme/tokens/app_space.dart';
import '../../../../core/widgets/layout/app_container.dart';
import '../../../../core/widgets/layout/app_responsive_layout.dart';
import '../../../../core/widgets/primitives/app_section.dart';
import '../../../../core/widgets/primitives/brand_mark.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: AppSection(
        title: 'Notes',
        subtitle:
            'How I think about product work when speed and quality both matter.',
        child: AppResponsiveLayout(
          mobile: (_) => const _NotesList(crossAxisCount: 1),
          tablet: (_) => const _NotesList(crossAxisCount: 2),
          desktop: (_) => const _NotesList(crossAxisCount: 3),
          ultraWide: (_) => const _NotesList(crossAxisCount: 3),
        ),
      ),
    );
  }
}

class _NotesList extends StatelessWidget {
  const _NotesList({required this.crossAxisCount});

  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    if (crossAxisCount == 1) {
      return Column(
        children: AppData.notes
            .map(
              (note) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpace.md),
                child: _NoteCard(note: note),
              ),
            )
            .toList(),
      );
    }

    return GridView.builder(
      itemCount: AppData.notes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: AppSpace.md,
        crossAxisSpacing: AppSpace.md,
        childAspectRatio: crossAxisCount == 2 ? 1.55 : 1.18,
      ),
      itemBuilder: (context, index) => _NoteCard(note: AppData.notes[index]),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BrandMark(size: 30),
          const SizedBox(height: AppSpace.lg),
          Text(
            note,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
