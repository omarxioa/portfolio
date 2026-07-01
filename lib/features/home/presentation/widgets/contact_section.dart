import 'package:flutter/material.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/theme/tokens/app_space.dart';
import '../../../../core/widgets/layout/app_container.dart';
import '../../../../core/widgets/primitives/app_button.dart';
import '../../../../core/widgets/primitives/app_section.dart';
import '../../../../core/widgets/primitives/app_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({
    super.key,
    required this.onGithub,
    required this.onLinkedIn,
    required this.onSendEmail,
  });

  final VoidCallback onGithub;
  final VoidCallback onLinkedIn;
  final void Function(String subject, String message) onSendEmail;

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool get _canSubmit => _messageController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _subjectController.addListener(_handleInputChange);
    _messageController.addListener(_handleInputChange);
  }

  @override
  void dispose() {
    _subjectController.removeListener(_handleInputChange);
    _messageController.removeListener(_handleInputChange);
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleInputChange() {
    setState(() {});
  }

  void _submitForm() {
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add a short message before sending.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    widget.onSendEmail(subject, message);
    _subjectController.clear();
    _messageController.clear();
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your draft opened in your email client.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: AppSection(
        title: 'Contact',
        subtitle:
            'Share your idea and timeline. I usually reply within 24 hours.',
        surface: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _subjectController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Subject',
                hintText: 'Project intro in one sentence',
              ),
            ),
            const SizedBox(height: AppSpace.md),
            TextField(
              controller: _messageController,
              maxLines: 5,
              minLines: 4,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) {
                if (_canSubmit) {
                  _submitForm();
                }
              },
              decoration: const InputDecoration(
                labelText: 'Message',
                hintText:
                    'What are you building, for who, and what timeline do you have?',
              ),
            ),
            const SizedBox(height: AppSpace.lg),
            AppButton(
              label: 'Send Email',
              icon: Icons.send_rounded,
              onPressed: _canSubmit ? _submitForm : null,
              variant: AppButtonVariant.primary,
            ),
            const SizedBox(height: AppSpace.lg),
            Wrap(
              spacing: AppSpace.sm,
              runSpacing: AppSpace.sm,
              children: [
                AppButton(
                  label: 'GitHub',
                  icon: Icons.code_rounded,
                  onPressed: widget.onGithub,
                  variant: AppButtonVariant.secondary,
                ),
                AppButton(
                  label: 'LinkedIn',
                  icon: Icons.business_center_rounded,
                  onPressed: widget.onLinkedIn,
                  variant: AppButtonVariant.secondary,
                ),
                AppButton(
                  label: 'Use project template',
                  icon: Icons.edit_note_rounded,
                  onPressed: () {
                    _subjectController.text =
                        _subjectController.text.trim().isEmpty
                        ? 'Flutter app inquiry'
                        : _subjectController.text;
                    if (_messageController.text.trim().isEmpty) {
                      _messageController.text =
                          'Hi Omar,\n\nProject: \nGoal: \nTimeline: \nBudget range: \n\nThanks!';
                    }
                  },
                  variant: AppButtonVariant.secondary,
                ),
              ],
            ),
            const SizedBox(height: AppSpace.md),
            AppSubtitle(text: 'Direct email: ${AppData.email}'),
          ],
        ),
      ),
    );
  }
}
