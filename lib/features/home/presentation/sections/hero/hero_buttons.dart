import 'package:flutter/material.dart';

import '../../../../../core/widgets/primitives/app_button.dart';

class HeroButtons extends StatelessWidget {
  const HeroButtons({
    super.key,
    required this.onSelectedWorkPressed,
    required this.onLetsTalkPressed,
  });

  final VoidCallback onSelectedWorkPressed;
  final VoidCallback onLetsTalkPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            AppButton(
              label: 'View Work',
              onPressed: onSelectedWorkPressed,
              variant: AppButtonVariant.primary,
            ),
            AppButton(
              label: 'Let\'s talk',
              onPressed: onLetsTalkPressed,
              variant: AppButtonVariant.secondary,
            ),
          ],
        ),
      ],
    );
  }
}
