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

abstract final class AppData {
  static const name = 'Omar Abdelnaby';

  static const title = 'Flutter Developer';

  static const email = 'your@email.com';

  static const github = 'https://github.com/omarxioa';

  static const linkedin = 'https://www.linkedin.com/in/omar-xioa/';

  static const about =
      'Senior Flutter Developer with 5+ years of experience building scalable mobile applications. Founder of SOAcode and experienced in leading development teams, architecting enterprise solutions, and delivering production-ready applications for startups and businesses.';

  static const heroSummary = '5+ years building scalable mobile apps';

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
    ExperienceModel(
      company: 'Tera',
      role: 'iOS Developer',
      duration: '2018 - 2019',
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
}
