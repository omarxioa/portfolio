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
    required this.onEmail,
    required this.onWhatsApp,
    required this.onLinkedIn,
    required this.onGithub,
  });

  final VoidCallback onEmail;
  final VoidCallback onWhatsApp;
  final VoidCallback onLinkedIn;
  final VoidCallback onGithub;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppContainer(
      child: AppSection(
        title: 'Contact',
        subtitle:
            'Email is the surest way to reach me. WhatsApp, LinkedIn, and '
            'GitHub all work too.',
        surface: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: AppSpace.md,
              runSpacing: AppSpace.md,
              children: [
                _ContactIconButton(
                  label: 'Email',
                  icon: FontAwesomeIcons.solidEnvelope,
                  onTap: onEmail,
                  primary: true,
                ),
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
            const SizedBox(height: AppSpace.md),
            SelectableText(
              AppData.email,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryText,
              ),
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
    this.primary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final foreground = primary ? Colors.black : AppColors.text;

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
            color: primary
                ? AppColors.lime
                : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadius.medium),
            border: Border.all(
              color: primary
                  ? AppColors.lime
                  : Colors.white.withValues(alpha: 0.10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icon, size: 18, color: foreground),
              const SizedBox(width: AppSpace.sm),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: foreground,
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
