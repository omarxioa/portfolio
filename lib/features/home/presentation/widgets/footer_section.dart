import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import '../../../../core/theme/tokens/app_radius.dart';
import '../../../../core/theme/tokens/app_space.dart';
import '../../../../core/widgets/layout/app_container.dart';
import '../../../../core/widgets/primitives/app_section.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({
    super.key,
    required this.onWhatsApp,
    required this.onLinkedIn,
    required this.onGithub,
  });

  final VoidCallback onWhatsApp;
  final VoidCallback onLinkedIn;
  final VoidCallback onGithub;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppContainer(
      child: AppSection(
        title: 'Contact',
        subtitle: 'Reach me directly on WhatsApp, LinkedIn, or GitHub.',
        surface: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: AppSpace.md,
              runSpacing: AppSpace.md,
              children: [
                _ContactIconButton(
                  label: 'WhatsApp',
                  icon: FontAwesomeIcons.whatsapp,
                  onTap: onWhatsApp,
                ),
                _ContactIconButton(
                  label: 'LinkedIn',
                  icon: FontAwesomeIcons.linkedinIn,
                  onTap: onLinkedIn,
                ),
                _ContactIconButton(
                  label: 'GitHub',
                  icon: FontAwesomeIcons.github,
                  onTap: onGithub,
                ),
              ],
            ),
            const SizedBox(height: AppSpace.lg),
            Text(
              '© ${DateTime.now().year} ${AppData.name}. All rights reserved.',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactIconButton extends StatelessWidget {
  const _ContactIconButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.md,
            vertical: AppSpace.md,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadius.medium),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icon, size: 18, color: AppColors.text),
              const SizedBox(width: AppSpace.sm),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
