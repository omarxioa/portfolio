import 'package:flutter/material.dart';

import '../../../../../core/constants/app_data.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/tokens/app_radius.dart';
import '../../../../../core/theme/tokens/app_shadows.dart';
import '../../../../../core/theme/tokens/app_space.dart';
import '../../../../../core/theme/tokens/motion.dart';
import '../../../../../core/widgets/primitives/app_glass.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({
    super.key,
    required this.pointerShift,
    required this.dimension,
  });

  final Offset pointerShift;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: dimension,
        height: dimension,
        child: AnimatedSlide(
          duration: Motion.normal,
          curve: Motion.standard,
          offset: Offset(pointerShift.dx / 200, pointerShift.dy / 200),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              boxShadow: [...AppShadows.card],
            ),
            child: AppGlass(
              padding: const EdgeInsets.all(AppSpace.lg),
              showBorder: false,
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              child: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.large),
                      child: Transform.scale(
                        scale: 1.12,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(
                            AppData.heroImageAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return Container(
                                color: AppColors.surfaceElevated,
                                alignment: Alignment.center,
                                child: Text(
                                  'Your Portrait',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.flutter_dash_rounded,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.88),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Flutter',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.88),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
