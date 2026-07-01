import 'package:flutter/material.dart';

import '../../../../../core/widgets/primitives/app_tag.dart';

class HeroBadges extends StatelessWidget {
  const HeroBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.02),
      ),
      child: const Padding(
        padding: EdgeInsets.all(2),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppBadge(label: 'Open to Product Teams'),
            AppTag(label: 'Mobile Architecture'),
            AppTag(label: 'Shipping at Scale'),
          ],
        ),
      ),
    );
  }
}
