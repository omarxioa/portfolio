class ProjectModel {
  final String title;
  final String description;
  final String image;
  final String githubUrl;
  final List<String> technologies;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.image,
    required this.githubUrl,
    required this.technologies,
  });
}
