import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/glass_container.dart';
import 'stat_pill.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onDownloadCv,
  });

  final VoidCallback onViewProjects;
  final VoidCallback onDownloadCv;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _ambientController;
  Alignment _pointerAlignment = const Alignment(0.25, -0.2);

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();

    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _introController.dispose();
    _ambientController.dispose();
    super.dispose();
  }

  Animation<double> _interval(double begin, double end) {
    return CurvedAnimation(
      parent: _introController,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
  }

  void _updatePointer(PointerHoverEvent event, BoxConstraints constraints) {
    if (constraints.maxWidth <= 0 || constraints.maxHeight <= 0) {
      return;
    }

    final dx = (event.localPosition.dx / constraints.maxWidth) * 2 - 1;
    final dy = (event.localPosition.dy / constraints.maxHeight) * 2 - 1;

    setState(() {
      _pointerAlignment = Alignment(dx.clamp(-1, 1), dy.clamp(-1, 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleAnim = _interval(0.0, 0.4);
    final subtitleAnim = _interval(0.2, 0.6);
    final chipAnim = _interval(0.45, 0.75);
    final buttonAnim = _interval(0.62, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (event) => _updatePointer(event, constraints),
          onExit: (_) {
            setState(() {
              _pointerAlignment = const Alignment(0.25, -0.2);
            });
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedBuilder(
                    animation: _ambientController,
                    builder: (context, _) {
                      final t = _ambientController.value * 2 * math.pi;

                      return Stack(
                        children: [
                          Positioned(
                            left: -80 + math.sin(t) * 24,
                            top: -64 + math.cos(t * 0.8) * 18,
                            child: _GlowBlob(
                              size: 260,
                              color: AppColors.primary.withValues(alpha: 0.16),
                            ),
                          ),
                          Positioned(
                            right: -90 + math.cos(t * 1.1) * 28,
                            bottom: -70 + math.sin(t * 1.2) * 22,
                            child: _GlowBlob(
                              size: 280,
                              color: AppColors.primary.withValues(alpha: 0.12),
                            ),
                          ),
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 180),
                            alignment: _pointerAlignment,
                            child: _GlowBlob(
                              size: 240,
                              color: const Color(0x66FFFFFF),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              GlassContainer(
                borderRadius: 20,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FadeSlideIn(
                      animation: titleAnim,
                      child: Text(
                        'Hi, I\'m ${AppData.name}',
                        style: textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.05,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _FadeSlideIn(
                      animation: subtitleAnim,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppData.title,
                            style: textTheme.titleLarge?.copyWith(
                              color: AppColors.secondaryText,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            AppData.heroSummary,
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppColors.secondaryText,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _FadeSlideIn(
                      animation: chipAnim,
                      child: const Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          StatPill(label: 'Open to Senior Flutter Roles'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _FadeSlideIn(
                      animation: buttonAnim,
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          CustomButton(
                            label: 'View Projects',
                            icon: Icons.work_outline,
                            onPressed: widget.onViewProjects,
                            variant: CustomButtonVariant.secondary,
                          ),
                          CustomButton(
                            label: 'Download CV',
                            onPressed: widget.onDownloadCv,
                            icon: Icons.download_rounded,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FadeSlideIn extends StatelessWidget {
  const _FadeSlideIn({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.14),
      end: Offset.zero,
    ).animate(animation);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(position: offsetAnimation, child: child),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}
