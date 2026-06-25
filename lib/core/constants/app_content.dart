class ExperienceEntry {
  const ExperienceEntry({
    required this.company,
    required this.role,
    required this.duration,
  });

  final String company;
  final String role;
  final String duration;
}

class ProjectEntry {
  const ProjectEntry({required this.title, required this.details});

  final String title;
  final List<String> details;
}

abstract final class AppContent {
  static const String name = 'Omar Abdelnaby';

  static const List<String> roles = [
    'Senior Flutter Developer',
    'Mobile Team Lead',
    'Founder @ SOAcode',
  ];

  static const List<String> heroStats = [
    '5+ Years Experience',
    '20+ Mobile Applications Delivered',
    'Team Leadership & Architecture',
  ];

  static const String about =
      'Senior Flutter Developer with 5+ years of experience building scalable mobile applications. Founder of SOAcode and experienced in leading development teams, architecting enterprise solutions, and delivering production-ready applications for startups and businesses.';

  static const List<ExperienceEntry> experiences = [
    ExperienceEntry(
      company: 'SOAcode',
      role: 'Founder & Senior Flutter Developer',
      duration: '2021 - Present',
    ),
    ExperienceEntry(
      company: 'Syntax',
      role: 'DevOps Engineer',
      duration: '2019 - 2021',
    ),
    ExperienceEntry(
      company: 'Tera',
      role: 'iOS Developer',
      duration: '2018 - 2019',
    ),
  ];

  static const List<ProjectEntry> featuredProjects = [
    ProjectEntry(
      title: 'Medication Management Platform',
      details: ['Riverpod', 'Clean Architecture', 'Notifications'],
    ),
    ProjectEntry(
      title: 'Enterprise Mobile Solutions',
      details: ['20+ Client Applications'],
    ),
    ProjectEntry(
      title: 'Flutter Architecture Template',
      details: ['Open Source'],
    ),
  ];

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

  static const List<String> contacts = [
    'GitHub',
    'LinkedIn',
    'Email',
    'WhatsApp',
  ];
}
