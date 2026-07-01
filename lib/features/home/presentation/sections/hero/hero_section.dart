import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../core/theme/tokens/app_breakpoints.dart';
import '../../../../../core/theme/tokens/app_radius.dart';
import '../../../../../core/theme/tokens/app_space.dart';
import '../../../../../core/widgets/layout/app_container.dart';
import '../../../../../core/widgets/layout/app_responsive_layout.dart';
import 'hero_content.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onSelectedWorkPressed,
    required this.onLetsTalkPressed,
  });

  final VoidCallback onSelectedWorkPressed;
  final VoidCallback onLetsTalkPressed;

  @override
  Widget build(BuildContext context) {
    final viewport = AppBreakpoints.fromWidth(MediaQuery.sizeOf(context).width);

    return Container(
      constraints: BoxConstraints(
        minHeight: switch (viewport) {
          AppViewport.mobile => 500,
          AppViewport.tablet => 560,
          AppViewport.desktop => 600,
          AppViewport.ultraWide => 620,
        },
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.large),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0C0C0C), Color(0xFF060606)],
                  ),
                ),
                child: CustomPaint(painter: _NoisePainter()),
              ),
            ),
          ),
          AppContainer(
            child: AppResponsiveLayout(
              mobile: (_) => _HeroTextLayout(
                onSelectedWorkPressed: onSelectedWorkPressed,
                onLetsTalkPressed: onLetsTalkPressed,
              ),
              tablet: (_) => _HeroTextLayout(
                onSelectedWorkPressed: onSelectedWorkPressed,
                onLetsTalkPressed: onLetsTalkPressed,
              ),
              desktop: (_) => _HeroTextLayout(
                onSelectedWorkPressed: onSelectedWorkPressed,
                onLetsTalkPressed: onLetsTalkPressed,
              ),
              ultraWide: (_) => _HeroTextLayout(
                onSelectedWorkPressed: onSelectedWorkPressed,
                onLetsTalkPressed: onLetsTalkPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroTextLayout extends StatelessWidget {
  const _HeroTextLayout({
    required this.onSelectedWorkPressed,
    required this.onLetsTalkPressed,
  });

  final VoidCallback onSelectedWorkPressed;
  final VoidCallback onLetsTalkPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.xl, bottom: AppSpace.lg),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 1024;

          return Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: HeroContent(
                  onSelectedWorkPressed: onSelectedWorkPressed,
                  onLetsTalkPressed: onLetsTalkPressed,
                ),
              ),
              Align(
                alignment: isNarrow ? Alignment.topRight : Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: AppSpace.xs,
                    top: isNarrow ? AppSpace.xs : 0,
                  ),
                  child: _HeroSideRail(compact: isNarrow),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroSideRail extends StatelessWidget {
  const _HeroSideRail({this.compact = false});

  static const _items = ['6+ Years', '20+ Apps', 'iOS & Android'];
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return IgnorePointer(
      child: Opacity(
        opacity: 0.78,
        child: Container(
          width: compact ? 132 : 148,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.md,
            vertical: AppSpace.md,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppRadius.medium),
            border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final item in _items) ...[
                Text(
                  item,
                  style: textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                    letterSpacing: compact ? 0.1 : 0.2,
                    fontSize: compact ? 11.5 : null,
                  ),
                ),
                if (item != _items.last)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 18,
                      height: 1,
                      color: Colors.white.withValues(alpha: 0.14),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Deterministic dot-grid — same pattern every paint
    final rng = math.Random(42);
    final dot = Paint()..style = PaintingStyle.fill;

    const spacing = 80.0;
    for (double y = spacing / 2; y < size.height; y += spacing) {
      for (double x = spacing / 2; x < size.width; x += spacing) {
        final jx = x + (rng.nextDouble() - 0.5) * 14;
        final jy = y + (rng.nextDouble() - 0.5) * 14;
        final opacity = 0.04 + rng.nextDouble() * 0.09;
        final radius = 0.6 + rng.nextDouble() * 0.6;
        dot.color = Colors.white.withValues(alpha: opacity);
        canvas.drawCircle(Offset(jx, jy), radius, dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
