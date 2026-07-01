import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../theme/tokens/app_radius.dart';
import '../../theme/tokens/app_shadows.dart';
import '../../theme/tokens/app_space.dart';
import 'app_title.dart';

class AppSection extends StatelessWidget {
  const AppSection({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.padding,
    this.surface = false,
    this.surfacePadding = const EdgeInsets.all(AppSpace.lg),
  });

  final String? title;
  final String? subtitle;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool surface;
  final EdgeInsetsGeometry surfacePadding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final verticalPadding = width < 720 ? AppSpace.xl : 40.0;

    final sectionChild = surface
        ? DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.medium),
              border: Border.all(color: Colors.white12),
              boxShadow: AppShadows.card,
            ),
            child: Padding(padding: surfacePadding, child: child),
          )
        : child;

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            AppTitle(text: title!),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpace.sm),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: AppSubtitle(text: subtitle!),
              ),
            ],
            const SizedBox(height: AppSpace.lg),
          ],
          sectionChild,
        ],
      ),
    );
  }
}
