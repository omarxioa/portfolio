/**
 * Single source of truth for site content — the Next.js equivalent of the old
 * Flutter `app_data.dart`. Copy is kept outcome-shaped and deliberately free
 * of numbers that cannot be backed up in an interview.
 */

export const site = {
  name: "Omar Abdelnaby",
  title: "Mobile Software Engineer",
  url: "https://omarabdelnaby.dev",
  email: "omarxioa@gmail.com",
  emailSubject: "Project enquiry from your portfolio",
  github: "https://github.com/omarxioa",
  linkedin: "https://www.linkedin.com/in/omar-xioa/",
  whatsAppNumber: "201140222004",
  cvPath: "/cv/Omar-cv.pdf",
  location: "Egypt",
  availability: "Available for work",
  heroGreeting: "Hi, I'm Omar.",
  heroRole: ["Mobile Software", "Engineer."],
  heroTypingPrefix: "Building ",
  heroTypingPhrases: [
    "products people love.",
    "offline-first experiences.",
    "scalable mobile products.",
    "delightful user experiences.",
    "reliable Flutter apps.",
  ],
  about:
    "Mobile Software Engineer with 5+ years building production-ready iOS " +
    "and Android applications with Flutter, and seven in software. I founded SOAcode, where I lead mobile " +
    "development for client and in-house products: architecture, delivery, " +
    "and the standards the team builds against.",
  skills: [
    "Flutter",
    "Dart",
    "Riverpod",
    "Clean Architecture",
    "Firebase",
    "REST APIs",
    "Git",
    "CI/CD",
    "SQLite",
    "Hive",
    "Leadership",
  ],
  notes: [
    "I care about product clarity as much as implementation quality.",
    "I use architecture when it earns speed, reliability, and easier team scaling.",
    "I work closely with design, backend, and product to ship complete experiences.",
  ],
} as const;

export function mailtoUrl(): string {
  return `mailto:${site.email}?subject=${encodeURIComponent(site.emailSubject)}`;
}

export function whatsAppUrl(message?: string): string {
  const text = encodeURIComponent(
    message ??
      "Hi Omar, I saw your portfolio and want to talk about a project.",
  );
  return `https://wa.me/${site.whatsAppNumber}?text=${text}`;
}

export function whatsAppInquiryUrl(projectName: string): string {
  return whatsAppUrl(
    `Hi Omar, I saw your portfolio and would like to discuss ${projectName}.`,
  );
}

export interface Experience {
  company: string;
  role: string;
  duration: string;
  achievements: string[];
  technologies: string[];
}

export const experiences: Experience[] = [
  {
    company: "SOAcode",
    role: "Founder & Mobile Development Team Lead",
    duration: "2021 - Present",
    achievements: [
      "Lead mobile development end to end, from architecture and estimation through store release and post-launch monitoring.",
      "Set the Flutter standards the team builds against: Riverpod for state, Clean Architecture boundaries between layers, and review on every pull request.",
      "Grew developers through code review, pairing, and hands-on onboarding to the codebase and its conventions.",
    ],
    technologies: [
      "Flutter",
      "Dart",
      "Riverpod",
      "Clean Architecture",
      "Firebase",
      "CI/CD",
    ],
  },
  {
    company: "Syntax",
    role: "DevOps Engineer",
    duration: "2019 - 2021",
    achievements: [
      "Built and maintained CI/CD pipelines, automating build and release workflows that had been run by hand.",
      "Managed deployment environments and production monitoring, shortening the path from merge to a verified release.",
    ],
    technologies: ["CI/CD", "Git"],
  },
];
