import 'package:flutter/material.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/widgets/social_button.dart';
import 'section_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.onGithub,
    required this.onLinkedIn,
    required this.onEmail,
  });

  final VoidCallback onGithub;
  final VoidCallback onLinkedIn;
  final VoidCallback onEmail;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Contact',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              SocialButton(
                label: 'GitHub',
                icon: Icons.code,
                onPressed: onGithub,
              ),
              SocialButton(
                label: 'LinkedIn',
                icon: Icons.business,
                onPressed: onLinkedIn,
              ),
              SocialButton(
                label: 'Email',
                icon: Icons.mail_outline,
                onPressed: onEmail,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(AppData.email, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
