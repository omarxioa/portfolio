import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  static const Color background = Color(0xFF0D1117);
  static const Color surface = Color(0xFF161B22);
  static const Color primary = Color(0xFF00D4FF);
  static const Color text = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFF8B949E);

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.dark(useMaterial3: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Omar Abdelnaby Portfolio',
      theme: baseTheme.copyWith(
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: primary,
          secondary: primary,
          surface: surface,
          onPrimary: background,
          onSurface: text,
        ),
        textTheme: baseTheme.textTheme.apply(
          bodyColor: text,
          displayColor: text,
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  static const List<String> skills = [
    'Flutter',
    'Dart',
    'Riverpod',
    'Clean Architecture',
    'Firebase',
    'REST APIs',
    'Git',
    'CI/CD',
    'SQLite',
    'Hive',
    'Leadership',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroSection(textTheme: textTheme),
                  const SizedBox(height: 32),
                  _SectionCard(
                    title: 'About Me',
                    child: Text(
                      'Senior Flutter Developer with 5+ years of experience building scalable mobile applications. Founder of SOAcode and experienced in leading development teams, architecting enterprise solutions, and delivering production-ready applications for startups and businesses.',
                      style: textTheme.bodyLarge?.copyWith(
                        color: PortfolioApp.secondaryText,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SectionCard(
                    title: 'Experience',
                    child: Column(
                      children: const [
                        _ExperienceItem(
                          company: 'SOAcode',
                          role: 'Founder & Senior Flutter Developer',
                          duration: '2021 - Present',
                        ),
                        SizedBox(height: 14),
                        _ExperienceItem(
                          company: 'Syntax',
                          role: 'DevOps Engineer',
                          duration: '2019 - 2021',
                        ),
                        SizedBox(height: 14),
                        _ExperienceItem(
                          company: 'Tera',
                          role: 'iOS Developer',
                          duration: '2018 - 2019',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SectionCard(
                    title: 'Featured Projects',
                    child: Column(
                      children: const [
                        _ProjectItem(
                          title: 'Medication Management Platform',
                          details: [
                            'Riverpod',
                            'Clean Architecture',
                            'Notifications',
                          ],
                        ),
                        SizedBox(height: 14),
                        _ProjectItem(
                          title: 'Enterprise Mobile Solutions',
                          details: ['20+ Client Applications'],
                        ),
                        SizedBox(height: 14),
                        _ProjectItem(
                          title: 'Flutter Architecture Template',
                          details: ['Open Source'],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SectionCard(
                    title: 'Skills',
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: skills
                          .map(
                            (skill) => Chip(
                              label: Text(skill),
                              backgroundColor: PortfolioApp.background,
                              side: const BorderSide(
                                color: PortfolioApp.primary,
                                width: 0.6,
                              ),
                              labelStyle: textTheme.bodyMedium?.copyWith(
                                color: PortfolioApp.text,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _SectionCard(
                    title: 'Contact',
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        _ContactChip(label: 'GitHub'),
                        _ContactChip(label: 'LinkedIn'),
                        _ContactChip(label: 'Email'),
                        _ContactChip(label: 'WhatsApp'),
                      ],
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

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PortfolioApp.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: PortfolioApp.primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Omar Abdelnaby',
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Senior Flutter Developer\nMobile Team Lead\nFounder @ SOAcode',
            style: textTheme.titleLarge?.copyWith(
              color: PortfolioApp.secondaryText,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _StatPill(label: '5+ Years Experience'),
              _StatPill(label: '20+ Mobile Applications Delivered'),
              _StatPill(label: 'Team Leadership & Architecture'),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download_rounded),
                label: const Text('Download CV'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PortfolioApp.primary,
                  foregroundColor: PortfolioApp.background,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.mail_outline),
                label: const Text('Contact Me'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: PortfolioApp.text,
                  side: const BorderSide(color: PortfolioApp.primary),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PortfolioApp.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: PortfolioApp.primary,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  const _ExperienceItem({
    required this.company,
    required this.role,
    required this.duration,
  });

  final String company;
  final String role;
  final String duration;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: PortfolioApp.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                role,
                style: textTheme.bodyLarge?.copyWith(
                  color: PortfolioApp.secondaryText,
                ),
              ),
              Text(
                duration,
                style: textTheme.bodyMedium?.copyWith(
                  color: PortfolioApp.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectItem extends StatelessWidget {
  const _ProjectItem({required this.title, required this.details});

  final String title;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: details
              .map(
                (item) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: PortfolioApp.background,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: PortfolioApp.secondaryText.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    item,
                    style: textTheme.bodySmall?.copyWith(
                      color: PortfolioApp.secondaryText,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: PortfolioApp.background,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: PortfolioApp.secondaryText.withValues(alpha: 0.35),
        ),
      ),
      child: Text(
        label,
        style: textTheme.bodyMedium?.copyWith(
          color: PortfolioApp.secondaryText,
        ),
      ),
    );
  }
}

class _ContactChip extends StatelessWidget {
  const _ContactChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: () {},
      backgroundColor: PortfolioApp.background,
      side: const BorderSide(color: PortfolioApp.primary),
      labelStyle: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: PortfolioApp.text),
    );
  }
}
