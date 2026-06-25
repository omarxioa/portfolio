import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../core/widgets/responsive_wrapper.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';
import '../../../../core/widgets/terminal_intro_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const TerminalIntroStyle _introStyle = TerminalIntroStyle.classicCmd;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  double _scrollOffset = 0;
  bool _showIntro = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final nextOffset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;

    if ((nextOffset - _scrollOffset).abs() < 1) {
      return;
    }

    setState(() {
      _scrollOffset = nextOffset;
    });
  }

  void _notify(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label will be connected soon.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _onViewProjects(BuildContext context) async {
    final targetContext = _projectsKey.currentContext;
    if (targetContext == null) {
      _notify(context, 'Projects section not ready yet.');
      return;
    }

    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 850),
      curve: Curves.easeInOutCubic,
      alignment: 0.04,
    );
  }

  void _onDownloadCv(BuildContext context) {
    _notify(context, 'Download CV from assets/cv');
  }

  void _onGithub(BuildContext context) {
    _notify(context, AppData.github);
  }

  void _onLinkedIn(BuildContext context) {
    _notify(context, AppData.linkedin);
  }

  void _onEmail(BuildContext context) {
    _notify(context, AppData.email);
  }

  void _dismissIntro() {
    if (!_showIntro) return;
    setState(() {
      _showIntro = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _ParallaxBackground(scrollOffset: _scrollOffset),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: ResponsiveWrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeroSection(
                      onViewProjects: () => _onViewProjects(context),
                      onDownloadCv: () => _onDownloadCv(context),
                    ),
                    const SizedBox(height: 28),
                    RevealOnScroll(
                      controller: _scrollController,
                      delay: const Duration(milliseconds: 20),
                      child: const AboutSection(),
                    ),
                    const SizedBox(height: 18),
                    RevealOnScroll(
                      controller: _scrollController,
                      delay: const Duration(milliseconds: 60),
                      child: const ExperienceSection(),
                    ),
                    const SizedBox(height: 18),
                    RevealOnScroll(
                      controller: _scrollController,
                      delay: const Duration(milliseconds: 90),
                      child: KeyedSubtree(
                        key: _projectsKey,
                        child: const ProjectsSection(),
                      ),
                    ),
                    const SizedBox(height: 18),
                    RevealOnScroll(
                      controller: _scrollController,
                      delay: const Duration(milliseconds: 120),
                      child: const SkillsSection(),
                    ),
                    const SizedBox(height: 18),
                    RevealOnScroll(
                      controller: _scrollController,
                      delay: const Duration(milliseconds: 140),
                      child: ContactSection(
                        onGithub: () => _onGithub(context),
                        onLinkedIn: () => _onLinkedIn(context),
                        onEmail: () => _onEmail(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RevealOnScroll(
                      controller: _scrollController,
                      beginOffset: const Offset(0, 0.03),
                      delay: const Duration(milliseconds: 160),
                      child: const FooterSection(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 420),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _showIntro
                ? TerminalIntroOverlay(
                    key: const ValueKey('terminal-intro'),
                    onFinish: _dismissIntro,
                    style: _introStyle,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _ParallaxBackground extends StatelessWidget {
  const _ParallaxBackground({required this.scrollOffset});

  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final driftA = scrollOffset * 0.16;
    final driftB = scrollOffset * 0.11;
    final driftC = scrollOffset * 0.06;

    return IgnorePointer(
      child: Stack(
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.background, Color(0xFF0A0E14)],
              ),
            ),
            child: SizedBox.expand(),
          ),
          Positioned(
            top: -140 - driftA,
            left: -90,
            child: _ParallaxOrb(
              size: 320,
              color: AppColors.primary.withValues(alpha: 0.11),
            ),
          ),
          Positioned(
            top: 240 - driftB,
            right: -110,
            child: _ParallaxOrb(
              size: 360,
              color: AppColors.primary.withValues(alpha: 0.08),
            ),
          ),
          Positioned(
            bottom: -190 - driftC,
            left: 40,
            child: _ParallaxOrb(
              size: 300,
              color: AppColors.primary.withValues(alpha: 0.06),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParallaxOrb extends StatelessWidget {
  const _ParallaxOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}
