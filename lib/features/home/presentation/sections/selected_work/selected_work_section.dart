import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/tokens/app_breakpoints.dart';
import '../../../../../core/theme/tokens/app_radius.dart';
import '../../../../../core/theme/tokens/app_space.dart';
import '../../../../../core/theme/tokens/motion.dart';
import '../../../../../core/widgets/layout/app_container.dart';
import '../../../../../core/widgets/layout/app_responsive_layout.dart';
import '../../../../../core/widgets/primitives/app_section.dart';
import '../../../../../core/widgets/primitives/app_tag.dart';

final _selectedWorkActiveIndexProvider = StateProvider<int>((ref) => 0);
final _selectedWorkLightModeProvider = StateProvider<bool>((ref) => false);
final _selectedWorkSalatiActiveIndexProvider = StateProvider<int>((ref) => 0);
final _selectedWorkSalatiLightModeProvider = StateProvider<bool>(
  (ref) => false,
);
const _projectOrderLabel = '01';
const _projectName = 'myMed';
const _projectOrderLabelSalati = '02';
const _projectNameSalati = 'Salati';

class SelectedWorkSection extends ConsumerWidget {
  const SelectedWorkSection({super.key});

  static const List<_CaseStudyScreen> _screens = [
    _CaseStudyScreen(
      title: 'Today',
      subtitle: 'Daily plan, reminders, and caregiver support at a glance.',
      darkAssetPath: 'assets/images/today.png',
      lightAssetPath: 'assets/images/today_light.png',
      navIcon: Icons.home_rounded,
    ),
    _CaseStudyScreen(
      title: 'Progress',
      subtitle: 'Weekly consistency, streaks, and missed-dose recovery.',
      darkAssetPath: 'assets/images/progress.png',
      lightAssetPath: 'assets/images/progress_light.png',
      navIcon: Icons.bar_chart_rounded,
    ),
    _CaseStudyScreen(
      title: 'Treatment',
      subtitle: 'Medication timelines, instructions, and refill tracking.',
      darkAssetPath: 'assets/images/treatment.png',
      lightAssetPath: 'assets/images/treatment_light.png',
      navIcon: Icons.medication_rounded,
    ),
    _CaseStudyScreen(
      title: 'Support',
      subtitle: 'Caregiver activity, check-ins, and shared accountability.',
      darkAssetPath: 'assets/images/support.png',
      lightAssetPath: 'assets/images/support_light.png',
      navIcon: Icons.support_agent_rounded,
    ),
  ];

  static const List<_CaseStudyScreen> _salatiScreens = [
    _CaseStudyScreen(
      title: 'Home',
      subtitle:
          'Prayer overview, next prayer countdown, and reliable reminders.',
      darkAssetPath: 'assets/images/salati_home_dark.png',
      lightAssetPath: 'assets/images/salati_home_light.png',
      navIcon: Icons.home_rounded,
    ),
    _CaseStudyScreen(
      title: 'Qibla',
      subtitle: 'Compass guidance designed for stable everyday use.',
      darkAssetPath: 'assets/images/salati_compass_dark.png',
      lightAssetPath: 'assets/images/salati_compass_light.png',
      navIcon: Icons.explore_rounded,
    ),
    _CaseStudyScreen(
      title: 'Quran',
      subtitle: 'Quick surah access with calm reading-focused navigation.',
      darkAssetPath: "assets/images/salati_qura'n.png",
      lightAssetPath: "assets/images/salati_qura'n_light.png",
      navIcon: Icons.menu_book_rounded,
    ),
    _CaseStudyScreen(
      title: 'Settings',
      subtitle: 'Language, notifications, and prayer preferences in one place.',
      darkAssetPath: 'assets/images/salati_setting_dark.png',
      lightAssetPath: 'assets/images/salati_setting_light.png',
      navIcon: Icons.settings_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(_selectedWorkActiveIndexProvider);
    final isLightMode = ref.watch(_selectedWorkLightModeProvider);
    final salatiActiveIndex = ref.watch(_selectedWorkSalatiActiveIndexProvider);
    final salatiLightMode = ref.watch(_selectedWorkSalatiLightModeProvider);
    final width = MediaQuery.sizeOf(context).width;
    final bottomPadding = width < 720 ? AppSpace.xl : 40.0;

    return AppContainer(
      child: AppSection(
        title: 'Featured Personal Projects',
        subtitle:
            'A curated selection of products I\'ve designed and developed.',
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: AppResponsiveLayout(
          mobile: (_) => _SelectedWorkList(
            compact: true,
            activeIndex: activeIndex,
            isLightMode: isLightMode,
            onTabSelected: (index) {
              ref.read(_selectedWorkActiveIndexProvider.notifier).state = index;
            },
            onModeChanged: (enabled) {
              ref.read(_selectedWorkLightModeProvider.notifier).state = enabled;
            },
            salatiActiveIndex: salatiActiveIndex,
            salatiLightMode: salatiLightMode,
            onSalatiTabSelected: (index) {
              ref.read(_selectedWorkSalatiActiveIndexProvider.notifier).state =
                  index;
            },
            onSalatiModeChanged: (enabled) {
              ref.read(_selectedWorkSalatiLightModeProvider.notifier).state =
                  enabled;
            },
            myMedScreens: _screens,
            salatiScreens: _salatiScreens,
          ),
          tablet: (_) => _SelectedWorkList(
            compact: false,
            activeIndex: activeIndex,
            isLightMode: isLightMode,
            onTabSelected: (index) {
              ref.read(_selectedWorkActiveIndexProvider.notifier).state = index;
            },
            onModeChanged: (enabled) {
              ref.read(_selectedWorkLightModeProvider.notifier).state = enabled;
            },
            salatiActiveIndex: salatiActiveIndex,
            salatiLightMode: salatiLightMode,
            onSalatiTabSelected: (index) {
              ref.read(_selectedWorkSalatiActiveIndexProvider.notifier).state =
                  index;
            },
            onSalatiModeChanged: (enabled) {
              ref.read(_selectedWorkSalatiLightModeProvider.notifier).state =
                  enabled;
            },
            myMedScreens: _screens,
            salatiScreens: _salatiScreens,
          ),
          desktop: (_) => _SelectedWorkList(
            compact: false,
            activeIndex: activeIndex,
            isLightMode: isLightMode,
            onTabSelected: (index) {
              ref.read(_selectedWorkActiveIndexProvider.notifier).state = index;
            },
            onModeChanged: (enabled) {
              ref.read(_selectedWorkLightModeProvider.notifier).state = enabled;
            },
            salatiActiveIndex: salatiActiveIndex,
            salatiLightMode: salatiLightMode,
            onSalatiTabSelected: (index) {
              ref.read(_selectedWorkSalatiActiveIndexProvider.notifier).state =
                  index;
            },
            onSalatiModeChanged: (enabled) {
              ref.read(_selectedWorkSalatiLightModeProvider.notifier).state =
                  enabled;
            },
            myMedScreens: _screens,
            salatiScreens: _salatiScreens,
          ),
          ultraWide: (_) => _SelectedWorkList(
            compact: false,
            activeIndex: activeIndex,
            isLightMode: isLightMode,
            onTabSelected: (index) {
              ref.read(_selectedWorkActiveIndexProvider.notifier).state = index;
            },
            onModeChanged: (enabled) {
              ref.read(_selectedWorkLightModeProvider.notifier).state = enabled;
            },
            salatiActiveIndex: salatiActiveIndex,
            salatiLightMode: salatiLightMode,
            onSalatiTabSelected: (index) {
              ref.read(_selectedWorkSalatiActiveIndexProvider.notifier).state =
                  index;
            },
            onSalatiModeChanged: (enabled) {
              ref.read(_selectedWorkSalatiLightModeProvider.notifier).state =
                  enabled;
            },
            myMedScreens: _screens,
            salatiScreens: _salatiScreens,
          ),
        ),
      ),
    );
  }
}

class _SelectedWorkList extends StatelessWidget {
  const _SelectedWorkList({
    required this.compact,
    required this.activeIndex,
    required this.isLightMode,
    required this.onTabSelected,
    required this.onModeChanged,
    required this.salatiActiveIndex,
    required this.salatiLightMode,
    required this.onSalatiTabSelected,
    required this.onSalatiModeChanged,
    required this.myMedScreens,
    required this.salatiScreens,
  });

  final bool compact;
  final int activeIndex;
  final bool isLightMode;
  final ValueChanged<int> onTabSelected;
  final ValueChanged<bool> onModeChanged;
  final int salatiActiveIndex;
  final bool salatiLightMode;
  final ValueChanged<int> onSalatiTabSelected;
  final ValueChanged<bool> onSalatiModeChanged;
  final List<_CaseStudyScreen> myMedScreens;
  final List<_CaseStudyScreen> salatiScreens;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SelectedWorkCard(
          screens: myMedScreens,
          projectOrderLabel: _projectOrderLabel,
          projectName: _projectName,
          description:
              'A medication management app designed to help patients stay on track with their treatment through reminders, progress tracking and caregiver support.',
          problem: 'Patients forget medications.',
          solution: 'Offline reminders + adherence tracking + support circle.',
          impact:
              'Built as a scalable Flutter application with clean architecture and local-first synchronization.',
          technologies: const [
            'Flutter',
            'Riverpod',
            'Clean Architecture',
            'SQLite',
            'Notifications',
            'Offline Sync',
          ],
          activeIndex: activeIndex,
          onTabSelected: onTabSelected,
          isLightMode: isLightMode,
          onModeChanged: onModeChanged,
          compact: compact,
          useActiveSubtitle: true,
          footerText: '',
          phoneScale: 1.0,
        ),
        const SizedBox(height: AppSpace.xl),
        _SelectedWorkCard(
          screens: salatiScreens,
          projectOrderLabel: _projectOrderLabelSalati,
          projectName: _projectNameSalati,
          description:
              'An offline-first Islamic companion designed to help Muslims stay connected to every prayer through reliable reminders, full Adhan playback, Quran access and Qibla guidance.',
          problem:
              'Missing prayers often happens because reminders stop working in the background or depend on internet connectivity.',
          solution:
              'Offline-first prayer reminders, full Adhan playback, accurate prayer calculations, Quran, Qibla and multilingual support.',
          impact:
              'Built as a scalable Flutter application focused on reliability, local scheduling, accessibility and distraction-free daily worship.',
          technologies: const [
            'Flutter',
            'Riverpod',
            'Offline First',
            'Prayer Times',
            'Local Notifications',
            'Qibla',
            'Audio Playback',
            'Localization',
          ],
          activeIndex: salatiActiveIndex,
          onTabSelected: onSalatiTabSelected,
          isLightMode: salatiLightMode,
          onModeChanged: onSalatiModeChanged,
          compact: compact,
          useActiveSubtitle: false,
          footerText:
              'Reliable reminders, Quran reading and prayer tracking in one calm experience.',
          phoneScale: 1.02,
        ),
      ],
    );
  }
}

class _SelectedWorkCard extends StatefulWidget {
  const _SelectedWorkCard({
    required this.screens,
    required this.projectOrderLabel,
    required this.projectName,
    required this.description,
    required this.problem,
    required this.solution,
    required this.impact,
    required this.technologies,
    required this.activeIndex,
    required this.onTabSelected,
    required this.isLightMode,
    required this.onModeChanged,
    required this.compact,
    required this.useActiveSubtitle,
    required this.footerText,
    required this.phoneScale,
  });

  final List<_CaseStudyScreen> screens;
  final String projectOrderLabel;
  final String projectName;
  final String description;
  final String problem;
  final String solution;
  final String impact;
  final List<String> technologies;
  final int activeIndex;
  final ValueChanged<int> onTabSelected;
  final bool isLightMode;
  final ValueChanged<bool> onModeChanged;
  final bool compact;
  final bool useActiveSubtitle;
  final String footerText;
  final double phoneScale;

  @override
  State<_SelectedWorkCard> createState() => _SelectedWorkCardState();
}

class _SelectedWorkCardState extends State<_SelectedWorkCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final shadow = _hovered
        ? BoxShadow(
            color: Colors.black.withValues(alpha: 0.50),
            blurRadius: 46,
            offset: const Offset(0, 24),
          )
        : BoxShadow(
            color: Colors.black.withValues(alpha: 0.36),
            blurRadius: 34,
            offset: const Offset(0, 18),
          );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: Motion.fast,
        curve: Motion.standard,
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: [shadow],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF161616), Color(0xFF0B0B0B)],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Padding(
              padding: EdgeInsets.all(
                widget.compact ? AppSpace.lg : AppSpace.xl,
              ),
              child: widget.compact
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CaseStudyCopy(
                          projectOrderLabel: widget.projectOrderLabel,
                          projectName: widget.projectName,
                          description: widget.description,
                          problem: widget.problem,
                          solution: widget.solution,
                          impact: widget.impact,
                          technologies: widget.technologies,
                          activeScreen: widget.screens[widget.activeIndex],
                          useActiveSubtitle: widget.useActiveSubtitle,
                          footerText: widget.footerText,
                        ),
                        const SizedBox(height: AppSpace.xl),
                        Center(
                          child: _PhoneColumn(
                            activeIndex: widget.activeIndex,
                            screens: widget.screens,
                            onTabSelected: widget.onTabSelected,
                            isLightMode: widget.isLightMode,
                            onModeChanged: widget.onModeChanged,
                            phoneScale: widget.phoneScale,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 11,
                          child: _CaseStudyCopy(
                            projectOrderLabel: widget.projectOrderLabel,
                            projectName: widget.projectName,
                            description: widget.description,
                            problem: widget.problem,
                            solution: widget.solution,
                            impact: widget.impact,
                            technologies: widget.technologies,
                            activeScreen: widget.screens[widget.activeIndex],
                            useActiveSubtitle: widget.useActiveSubtitle,
                            footerText: widget.footerText,
                          ),
                        ),
                        const SizedBox(width: AppSpace.xl),
                        Expanded(
                          flex: 10,
                          child: _PhoneColumn(
                            activeIndex: widget.activeIndex,
                            screens: widget.screens,
                            onTabSelected: widget.onTabSelected,
                            isLightMode: widget.isLightMode,
                            onModeChanged: widget.onModeChanged,
                            phoneScale: widget.phoneScale,
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

class _CaseStudyCopy extends StatelessWidget {
  const _CaseStudyCopy({
    required this.projectOrderLabel,
    required this.projectName,
    required this.description,
    required this.problem,
    required this.solution,
    required this.impact,
    required this.technologies,
    required this.activeScreen,
    required this.useActiveSubtitle,
    required this.footerText,
  });

  final String projectOrderLabel;
  final String projectName;
  final String description;
  final String problem;
  final String solution;
  final String impact;
  final List<String> technologies;
  final _CaseStudyScreen activeScreen;
  final bool useActiveSubtitle;
  final String footerText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 590),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            projectOrderLabel,
            style: textTheme.displayLarge?.copyWith(
              fontSize: 72,
              height: 0.84,
              fontWeight: FontWeight.w800,
              letterSpacing: -3.2,
              color: Colors.white.withValues(alpha: 0.16),
            ),
          ),
          const SizedBox(height: AppSpace.xs),
          Text(
            projectName,
            style: textTheme.displaySmall?.copyWith(
              fontSize: 32,
              height: 1.05,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: AppSpace.md),
          Text(
            description,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              height: 1.55,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: AppSpace.xl),
          _InfoBlock(label: 'Problem', value: problem),
          const SizedBox(height: AppSpace.lg),
          _InfoBlock(label: 'Solution', value: solution),
          const SizedBox(height: AppSpace.lg),
          _InfoBlock(label: 'Impact', value: impact),
          const SizedBox(height: AppSpace.xl),
          Wrap(
            spacing: AppSpace.xs,
            runSpacing: AppSpace.xs,
            children: technologies.map((tech) => AppTag(label: tech)).toList(),
          ),
          const SizedBox(height: AppSpace.lg),
          AnimatedOpacity(
            duration: Motion.fast,
            opacity: 0.9,
            child: Text(
              useActiveSubtitle ? activeScreen.subtitle : footerText,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryText,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneColumn extends StatelessWidget {
  const _PhoneColumn({
    required this.activeIndex,
    required this.screens,
    required this.onTabSelected,
    required this.isLightMode,
    required this.onModeChanged,
    required this.phoneScale,
  });

  final int activeIndex;
  final List<_CaseStudyScreen> screens;
  final ValueChanged<int> onTabSelected;
  final bool isLightMode;
  final ValueChanged<bool> onModeChanged;
  final double phoneScale;

  @override
  Widget build(BuildContext context) {
    final viewport = AppBreakpoints.fromWidth(MediaQuery.sizeOf(context).width);
    final baseMaxPhoneWidth =
        switch (viewport) {
          AppViewport.mobile => 320.0,
          AppViewport.tablet => 300.0,
          AppViewport.desktop => 260.0,
          AppViewport.ultraWide => 290.0,
        } *
        phoneScale;

    const preferredTabOrder = ['Today', 'Progress', 'Support', 'Treatment'];
    final tabIndices = <int>[
      ...preferredTabOrder
          .map((title) => screens.indexWhere((screen) => screen.title == title))
          .where((index) => index >= 0),
      ...List.generate(
        screens.length,
        (index) => index,
      ).where((index) => !preferredTabOrder.contains(screens[index].title)),
    ];
    final icons = tabIndices.map((index) => screens[index].navIcon).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PhoneModeToggle(
          isLightMode: isLightMode,
          onModeChanged: onModeChanged,
        ),
        const SizedBox(height: AppSpace.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final phoneWidth = constraints.maxWidth.isFinite
                ? constraints.maxWidth.clamp(0.0, baseMaxPhoneWidth)
                : baseMaxPhoneWidth;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: phoneWidth),
                  child: _PhoneMockup(
                    activeScreen: screens[activeIndex],
                    isLightMode: isLightMode,
                  ),
                ),
                const SizedBox(height: AppSpace.md),
                Text(
                  screens[activeIndex].title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.text,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpace.lg),
                SizedBox(
                  width: phoneWidth,
                  child: _CaseStudyTabs(
                    activeIndex: activeIndex,
                    icons: icons,
                    tabIndices: tabIndices,
                    onSelected: onTabSelected,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _PhoneMockup extends StatelessWidget {
  const _PhoneMockup({required this.activeScreen, required this.isLightMode});

  final _CaseStudyScreen activeScreen;
  final bool isLightMode;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.48,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(42),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2B2B2B), Color(0xFF111111), Color(0xFF1B1B1B)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x62000000),
              blurRadius: 44,
              offset: Offset(0, 28),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            color: Colors.black,
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const _PhoneBackdrop(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 380),
                  switchInCurve: Motion.standard,
                  switchOutCurve: Motion.standard,
                  transitionBuilder: (child, animation) {
                    final offset = Tween<Offset>(
                      begin: const Offset(0.015, 0.02),
                      end: Offset.zero,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(position: offset, child: child),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey(activeScreen.title),
                    child: Image.asset(
                      activeScreen.imagePath(isLightMode),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'Screenshot unavailable',
                            style: TextStyle(color: AppColors.secondaryText),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 7,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 96,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF000000),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneBackdrop extends StatelessWidget {
  const _PhoneBackdrop();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.8, -0.9),
          radius: 1.2,
          colors: [Color(0x1F6BE3C6), Color(0xFF0C1015), Color(0xFF090909)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: 112,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.10),
              ),
            ),
          ),
          Positioned(
            left: -40,
            bottom: -36,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primarySoft.withValues(alpha: 0.08),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaseStudyTabs extends StatefulWidget {
  const _CaseStudyTabs({
    required this.icons,
    required this.tabIndices,
    required this.activeIndex,
    required this.onSelected,
  });

  final List<IconData> icons;
  final List<int> tabIndices;
  final int activeIndex;
  final ValueChanged<int> onSelected;

  @override
  State<_CaseStudyTabs> createState() => _CaseStudyTabsState();
}

class _CaseStudyTabsState extends State<_CaseStudyTabs> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final tabWidgets = List.generate(widget.icons.length, (index) {
      final targetIndex = widget.tabIndices[index];
      final isActive = targetIndex == widget.activeIndex;
      final isHovered = index == _hoveredIndex;

      return MouseRegion(
        onEnter: (_) => setState(() => _hoveredIndex = index),
        onExit: (_) {
          if (_hoveredIndex == index) {
            setState(() => _hoveredIndex = null);
          }
        },
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onSelected(targetIndex),
          child: AnimatedContainer(
            duration: Motion.fast,
            curve: Motion.standard,
            padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.16)
                  : isHovered
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: isActive
                    ? AppColors.primary.withValues(alpha: 0.24)
                    : Colors.white.withValues(alpha: 0.06),
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.14),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ]
                  : const [],
            ),
            child: Icon(
              widget.icons[index],
              size: 18,
              color: isActive ? AppColors.text : AppColors.secondaryText,
            ),
          ),
        ),
      );
    });

    return Row(
      children: [
        for (var i = 0; i < tabWidgets.length; i++) ...[
          Expanded(child: tabWidgets[i]),
          if (i != tabWidgets.length - 1) const SizedBox(width: AppSpace.sm),
        ],
      ],
    );
  }
}

class _CaseStudyScreen {
  const _CaseStudyScreen({
    required this.title,
    required this.subtitle,
    required this.darkAssetPath,
    required this.lightAssetPath,
    required this.navIcon,
  });

  final String title;
  final String subtitle;
  final String darkAssetPath;
  final String lightAssetPath;
  final IconData navIcon;

  String imagePath(bool isLightMode) {
    return isLightMode ? lightAssetPath : darkAssetPath;
  }
}

class _PhoneModeToggle extends StatelessWidget {
  const _PhoneModeToggle({
    required this.isLightMode,
    required this.onModeChanged,
  });

  final bool isLightMode;
  final ValueChanged<bool> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModeButton(
            label: 'Dark',
            icon: Icons.dark_mode_rounded,
            isActive: !isLightMode,
            onTap: () => onModeChanged(false),
          ),
          _ModeButton(
            label: 'Light',
            icon: Icons.light_mode_rounded,
            isActive: isLightMode,
            onTap: () => onModeChanged(true),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Motion.fast,
        curve: Motion.standard,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.md,
          vertical: AppSpace.xs,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.18)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? AppColors.text : AppColors.secondaryText,
            ),
            const SizedBox(width: AppSpace.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isActive ? AppColors.text : AppColors.secondaryText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: AppColors.secondaryText.withValues(alpha: 0.86),
        letterSpacing: 1.9,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Eyebrow(text: label),
        const SizedBox(height: AppSpace.xs),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.text,
            height: 1.45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
