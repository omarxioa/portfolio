import '../../data/models/project_model.dart';

class ExperienceModel {
  final String company;
  final String role;
  final String duration;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.duration,
  });
}

class ProductModel {
  final String title;
  final String summary;
  final String impact;
  final List<String> stack;

  const ProductModel({
    required this.title,
    required this.summary,
    required this.impact,
    required this.stack,
  });
}

abstract final class AppData {
  static const name = 'Omar Abdelnaby';
  static const heroImageAsset = 'assets/images/avatar.png';
  static const cvAssetPath = 'assets/cv/omar_abdelnaby_cv.pdf';

  static const title = 'Mobile Software Engineer';

  static const heroLead = 'Hello. I\'m';

  static const heroName = 'Omar.';

  static const email = 'your@email.com';

  static const github = 'https://github.com/omarxioa';

  static const linkedin = 'https://www.linkedin.com/in/omar-xioa/';

  static const about =
      'Senior Flutter Developer with 5+ years of experience building scalable mobile applications. Founder of SOAcode and experienced in leading development teams, architecting enterprise solutions, and delivering production-ready applications for startups and businesses.';

  static const heroGreeting = 'Hello. I\'m Omar.';

  static const heroSummary =
      'I build product-first mobile experiences for healthcare, enterprise, and fast-moving teams.';

  static const heroRotatingWords = [
    'polished',
    'scalable',
    'beautiful',
    'fast',
    'reliable',
    'production-ready',
  ];

  static const heroPlatforms = ['Flutter', 'Android', 'iOS', 'Web'];

  static const skills = [
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

  static const notes = [
    'I care about product clarity as much as implementation quality.',
    'I use architecture when it earns speed, reliability, and easier team scaling.',
    'I work closely with design, backend, and product to ship complete experiences.',
  ];

  static const experiences = [
    ExperienceModel(
      company: 'SOAcode',
      role: 'Founder & Senior Flutter Developer',
      duration: '2021 - Present',
    ),
    ExperienceModel(
      company: 'Syntax',
      role: 'DevOps Engineer',
      duration: '2019 - 2021',
    ),
  ];

  static const projects = [
    ProjectModel(
      title: 'Medication Management Platform',
      description:
          'A reliable patient-focused app with reminders and tracking.',
      image: 'assets/images/medication_platform.png',
      githubUrl: github,
      technologies: ['Riverpod', 'Clean Architecture', 'Notifications'],
    ),
    ProjectModel(
      title: 'Enterprise Mobile Solutions',
      description: 'Delivered scalable apps for multiple businesses and teams.',
      image: 'assets/images/enterprise_solutions.png',
      githubUrl: github,
      technologies: ['20+ Client Applications', 'Architecture', 'CI/CD'],
    ),
    ProjectModel(
      title: 'Flutter Architecture Template',
      description: 'Opinionated template for production-ready Flutter apps.',
      image: 'assets/images/flutter_template.png',
      githubUrl: github,
      technologies: ['Open Source', 'Modular', 'Best Practices'],
    ),
  ];

  static const products = [
    ProductModel(
      title: 'Medication Platform',
      summary:
          'End-to-end medication workflow for patients and care teams with scheduling, refill reminders, and dose tracking.',
      impact:
          'Increased daily adherence by 37% and reduced missed-dose reports within the first quarter.',
      stack: ['Flutter', 'Offline-First', 'Notifications', 'Analytics'],
    ),
    ProductModel(
      title: 'Vendor Management System',
      summary:
          'Mobile-first operations suite to manage onboarding, approvals, catalog updates, and fulfillment visibility.',
      impact:
          'Cut vendor onboarding cycle from 12 days to 4 days across three regional teams.',
      stack: ['Flutter', 'Clean Architecture', 'Role Permissions', 'CI/CD'],
    ),
    ProductModel(
      title: 'Field Service Execution App',
      summary:
          'Technician-facing product for dispatch, checklists, customer signatures, and evidence capture from the field.',
      impact:
          'Improved first-visit completion rates by 24% through guided workflows and offline reliability.',
      stack: ['Flutter', 'Geo APIs', 'Sync Engine', 'Crash Reporting'],
    ),
  ];
}
