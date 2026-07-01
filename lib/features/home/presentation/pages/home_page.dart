import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/tokens/app_radius.dart';
import '../../../../core/theme/tokens/app_space.dart';
import '../../../../core/widgets/layout/app_container.dart';
import '../../../../core/widgets/terminal_intro_overlay.dart';
import '../sections/hero/hero_section.dart';
import '../sections/selected_work/selected_work_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const TerminalIntroStyle _introStyle = TerminalIntroStyle.classicCmd;
  static const double _desktopNavHeight = 58;
  static const double _mobileNavHeight = 64;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _selectedWorkKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();
  bool _showIntro = true;
  bool _showBackToTop = false;

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
    final shouldShow =
        _scrollController.hasClients && _scrollController.offset > 520;
    if (shouldShow == _showBackToTop) return;
    setState(() {
      _showBackToTop = shouldShow;
    });
  }

  void _notify(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> _scrollToSection(
    GlobalKey sectionKey, {
    double alignment = 0.06,
  }) async {
    final targetContext = sectionKey.currentContext;
    if (targetContext == null) return;

    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
      alignment: alignment,
    );
  }

  Future<void> _scrollToSelectedWork() => _scrollToSection(_selectedWorkKey);

  Future<void> _scrollToContact() async {
    await _scrollToSection(_footerKey, alignment: 0.98);
  }

  Future<void> _scrollToTop() async {
    if (!_scrollController.hasClients) return;
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _downloadCvFromAssets() async {
    const assetPath = AppData.cvAssetPath;

    bool exists = false;
    try {
      final manifestRaw = await rootBundle.loadString('AssetManifest.json');
      final manifest = jsonDecode(manifestRaw) as Map<String, dynamic>;
      exists = manifest.containsKey(assetPath);
    } catch (_) {
      exists = false;
    }

    if (!exists) {
      _notify('CV file not found. Add it at $assetPath');
      return;
    }

    final uri = Uri.parse('/$assetPath');
    final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!launched) {
      _notify('Unable to open CV asset.');
    }
  }

  void _dismissIntro() {
    if (!_showIntro) return;
    setState(() {
      _showIntro = false;
    });
  }

  Future<void> _openMobileNavSheet(List<_NavAction> actions) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final maxHeight = MediaQuery.sizeOf(sheetContext).height * 0.78;

        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpace.lg,
                  AppSpace.md,
                  AppSpace.lg,
                  AppSpace.lg,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jump to section',
                      style: Theme.of(sheetContext).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppSpace.sm),
                    ...actions.map(
                      (item) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(item.label),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                        ),
                        onTap: () {
                          Navigator.of(sheetContext).pop();
                          Future<void>.delayed(
                            const Duration(milliseconds: 120),
                            item.onTap,
                          );
                        },
                      ),
                    ),
                    const Divider(color: Colors.white12),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      leading: const Icon(
                        Icons.download_rounded,
                        color: Colors.black,
                      ),
                      tileColor: AppColors.lime,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                      ),
                      title: const Text(
                        'Download Resume',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        Future<void>.delayed(
                          const Duration(milliseconds: 120),
                          _downloadCvFromAssets,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isCompactNav = width < 700;
    final navReservedHeight = isCompactNav
        ? _mobileNavHeight
        : _desktopNavHeight;

    final sections = [
      _NavAction(label: 'Work', onTap: _scrollToSelectedWork),
      _NavAction(
        label: 'Experience',
        onTap: () => _scrollToSection(_experienceKey),
      ),
      _NavAction(label: 'Contact', onTap: _scrollToContact),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.background, Color(0xFF0A0A0A)],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _showIntro ? 0 : navReservedHeight + AppSpace.md,
                    ),
                    KeyedSubtree(
                      key: _heroKey,
                      child: HeroSection(
                        onSelectedWorkPressed: _scrollToSelectedWork,
                        onLetsTalkPressed: _scrollToContact,
                      ),
                    ),
                    KeyedSubtree(
                      key: _selectedWorkKey,
                      child: const SelectedWorkSection(),
                    ),
                    KeyedSubtree(
                      key: _experienceKey,
                      child: const ExperienceSection(),
                    ),
                    KeyedSubtree(key: _footerKey, child: const FooterSection()),
                  ],
                ),
              ),
            ),
          ),
          if (!_showIntro)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpace.sm),
                  child: AppContainer(
                    child: _TopNavBar(
                      actions: sections,
                      onResumeTap: _downloadCvFromAssets,
                      compact: isCompactNav,
                      onMenuTap: () => _openMobileNavSheet(sections),
                    ),
                  ),
                ),
              ),
            ),
          if (_showBackToTop && !_showIntro)
            Positioned(
              right: AppSpace.lg,
              bottom: AppSpace.lg,
              child: FloatingActionButton.small(
                onPressed: _scrollToTop,
                backgroundColor: AppColors.lime,
                foregroundColor: Colors.black,
                tooltip: 'Back to top',
                child: const Icon(Icons.keyboard_arrow_up_rounded),
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

class _NavAction {
  const _NavAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;
}

class _TopNavBar extends StatelessWidget {
  const _TopNavBar({
    required this.actions,
    required this.onResumeTap,
    required this.compact,
    this.onMenuTap,
  });

  final List<_NavAction> actions;
  final VoidCallback onResumeTap;
  final bool compact;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.md,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.82),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Omar',
                style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            FilledButton.icon(
              onPressed: onMenuTap,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.08),
                foregroundColor: AppColors.text,
                side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.md,
                  vertical: AppSpace.sm,
                ),
              ),
              icon: const Icon(Icons.menu_rounded, size: 18),
              label: const Text('Menu'),
            ),
            const SizedBox(width: AppSpace.xs),
            FilledButton(
              onPressed: onResumeTap,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.lime,
                foregroundColor: Colors.black,
                minimumSize: const Size(0, 44),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.lg,
                  vertical: AppSpace.md,
                ),
              ),
              child: const Text('Resume'),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.md, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          const Text(
            'Omar',
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: actions
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(right: AppSpace.xs),
                        child: TextButton(
                          onPressed: item.onTap,
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(WidgetState.hovered)) {
                                return AppColors.text;
                              }
                              return Colors.white.withValues(alpha: 0.68);
                            }),
                            overlayColor: WidgetStatePropertyAll(
                              Colors.white.withValues(alpha: 0.06),
                            ),
                            padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: AppSpace.md,
                                vertical: AppSpace.sm,
                              ),
                            ),
                          ),
                          child: Text(item.label),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          FilledButton(
            onPressed: onResumeTap,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.lime,
              foregroundColor: Colors.black,
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.lg,
                vertical: AppSpace.md,
              ),
            ),
            child: const Text('Resume'),
          ),
        ],
      ),
    );
  }
}
