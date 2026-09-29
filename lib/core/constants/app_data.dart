class ExperienceModel {
  final String company;
  final String role;
  final String duration;

  /// What the role actually delivered. Kept outcome-shaped rather than a list
  /// of responsibilities, and deliberately free of numbers that cannot be
  /// backed up in an interview.
  final List<String> achievements;

  final List<String> technologies;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.duration,
    this.achievements = const [],
    this.technologies = const [],
  });
}

abstract final class AppData {
  static const name = 'Omar Abdelnaby';
  static const cvAssetPath = 'assets/cv/Omar-cv.pdf';

  static const siteUrl = 'https://omarabdelnaby.dev';

  // Off web there is no launchable URL for a bundled asset, so the hosted copy
  // of the same file is used instead. Kept in sync with cvAssetPath.
  static const hostedCvUrl = '$siteUrl/assets/$cvAssetPath';

  static const title = 'Mobile Software Engineer';

  static const email = 'omarxioa@gmail.com';

  static const emailSubject = 'Project enquiry from your portfolio';

  static String get mailtoUrl =>
      'mailto:$email?subject=${Uri.encodeComponent(emailSubject)}';

  static const github = 'https://github.com/omarxioa';

  static const myMedRepoUrl = 'https://github.com/omarxioa/myMed';

  static const salatiRepoUrl = 'https://github.com/omarxioa/taweem_salati';

  static const linkedin = 'https://www.linkedin.com/in/omar-xioa/';

  // WhatsApp requires an international number in digits-only format.
  static const whatsAppNumber = '201140222004';

  static const whatsAppMessage =
      'Hi%20Omar%2C%20I%20saw%20your%20portfolio%20and%20want%20to%20talk%20about%20a%20project.';

  static const whatsAppUrl =
      'https://wa.me/$whatsAppNumber?text=$whatsAppMessage';

  static String whatsAppInquiryUrl(String projectName) {
    final message = Uri.encodeComponent(
      'Hi Omar, I saw your portfolio and would like to discuss $projectName.',
    );
    return 'https://wa.me/$whatsAppNumber?text=$message';
  }

  static const about =
      'Mobile Software Engineer with five years building Flutter applications '
      'and seven in software. I founded SOAcode, where I lead mobile '
      'development for client and in-house products: architecture, delivery, '
      'and the standards the team builds against.';

  static const heroAvailability = 'Available for work';

  static const heroGreeting = 'Hi, I\'m Omar.';

  /// Rendered as two lines, so the break is part of the copy.
  static const heroRole = 'Mobile Software\nEngineer.';

  static const heroTypingPrefix = 'Building ';

  static const heroTypingPhrases = [
    'products people love.',
    'offline-first experiences.',
    'scalable mobile products.',
    'delightful user experiences.',
    'reliable Flutter apps.',
  ];

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
      role: 'Founder & Mobile Development Team Lead',
      duration: '2021 - Present',
      achievements: [
        'Lead mobile development end to end, from architecture and estimation through store release and post-launch monitoring.',
        'Set the Flutter standards the team builds against: Riverpod for state, Clean Architecture boundaries between layers, and review on every pull request.',
        'Grew developers through code review, pairing, and hands-on onboarding to the codebase and its conventions.',
        'Shipped myMed and Salati to production, including offline-first data layers and notification scheduling that survives app termination and reboot.',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Riverpod',
        'Clean Architecture',
        'Firebase',
        'CI/CD',
      ],
    ),
    ExperienceModel(
      company: 'Syntax',
      role: 'DevOps Engineer',
      duration: '2019 - 2021',
      achievements: [
        'Built and maintained CI/CD pipelines, automating build and release workflows that had been run by hand.',
        'Managed deployment environments and production monitoring, shortening the path from merge to a verified release.',
      ],
      technologies: ['CI/CD', 'Git'],
    ),
  ];

}
