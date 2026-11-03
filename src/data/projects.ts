export interface ProjectScreen {
  title: string;
  subtitle: string;
  dark: string;
  light: string;
}

export interface Project {
  slug: string;
  order: string;
  name: string;
  tagline: string;
  description: string;
  problem: string;
  solution: string;
  impact: string;
  highlights: string[];
  contributions: string[];
  role: string;
  scope: string;
  duration: string;
  technologies: string[];
  repoUrl?: string;
  /** Not yet on the stores — rendered as a "coming soon" badge. */
  storeStatus: "coming-soon" | "live";
  screens: ProjectScreen[];
}

export const projects: Project[] = [
  {
    slug: "mymed",
    order: "01",
    name: "myMed",
    tagline: "Medication reminders that survive the real world.",
    description:
      "A medication management app designed to help patients stay on track with their treatment through reminders, progress tracking and caregiver support.",
    problem: "Patients forget medications.",
    solution: "Offline reminders + adherence tracking + support circle.",
    impact:
      "Engineered for the failure cases that break medication reminders: every screen reads from local storage and works with no network, and scheduled doses still fire after the app is killed, after Doze, and after a reboot.",
    highlights: [
      "Offline-first data layer",
      "Survives app kill & reboot",
      "Riverpod + Clean Architecture",
    ],
    contributions: [
      "Designed feature architecture with Riverpod + Clean Architecture.",
      "Implemented local persistence and sync-safe data flows.",
      "Built notification and reminder reliability across app states.",
    ],
    role: "Founder & Senior Flutter Developer",
    scope: "Product, Architecture, Delivery",
    duration: "2024 - Present",
    technologies: [
      "Flutter",
      "Riverpod",
      "Clean Architecture",
      "SQLite",
      "Notifications",
      "Offline Sync",
    ],
    repoUrl: "https://github.com/omarxioa/myMed",
    storeStatus: "coming-soon",
    screens: [
      {
        title: "Today",
        subtitle: "Daily plan, reminders, and caregiver support at a glance.",
        dark: "/images/today.webp",
        light: "/images/today_light.webp",
      },
      {
        title: "Progress",
        subtitle: "Weekly consistency, streaks, and missed-dose recovery.",
        dark: "/images/progress.webp",
        light: "/images/progress_light.webp",
      },
      {
        title: "Treatment",
        subtitle: "Medication timelines, instructions, and refill tracking.",
        dark: "/images/treatment.webp",
        light: "/images/treatment_light.webp",
      },
      {
        title: "Support",
        subtitle: "Caregiver activity, check-ins, and shared accountability.",
        dark: "/images/support.webp",
        light: "/images/support_light.webp",
      },
    ],
  },
  {
    slug: "salati",
    order: "02",
    name: "Salati",
    tagline: "An offline-first Islamic companion for every prayer.",
    description:
      "An offline-first Islamic companion designed to help Muslims stay connected to every prayer through reliable reminders, full Adhan playback, Quran access and Qibla guidance.",
    problem:
      "Missing prayers often happens because reminders stop working in the background or depend on internet connectivity.",
    solution:
      "Offline-first prayer reminders, full Adhan playback, accurate prayer calculations, Quran, Qibla and multilingual support.",
    impact:
      "Built as a scalable Flutter application focused on reliability, local scheduling, accessibility and distraction-free daily worship.",
    highlights: [
      "Offline-first runtime",
      "Reliable prayer alerts",
      "Multilingual UX",
    ],
    contributions: [
      "Engineered background-safe scheduling for prayer reminders.",
      "Integrated Quran, Qibla, and settings into one cohesive flow.",
      "Shaped interaction model for calm and focused daily usage.",
    ],
    role: "Founder & Senior Flutter Developer",
    scope: "Product, Architecture, Delivery",
    duration: "2024 - Present",
    technologies: [
      "Flutter",
      "Riverpod",
      "Clean Architecture",
      "Local Scheduling",
      "Localization",
      "Audio",
    ],
    repoUrl: "https://github.com/omarxioa/taweem_salati",
    storeStatus: "coming-soon",
    screens: [
      {
        title: "Home",
        subtitle:
          "Prayer overview, next prayer countdown, and reliable reminders.",
        dark: "/images/salati_home_dark.webp",
        light: "/images/salati_home_light.webp",
      },
      {
        title: "Qibla",
        subtitle: "Compass guidance designed for stable everyday use.",
        dark: "/images/salati_compass_dark.webp",
        light: "/images/salati_compass_light.webp",
      },
      {
        title: "Quran",
        subtitle: "Quick surah access with calm reading-focused navigation.",
        dark: "/images/salati_quran.webp",
        light: "/images/salati_quran_light.webp",
      },
      {
        title: "Settings",
        subtitle:
          "Language, notifications, and prayer preferences in one place.",
        dark: "/images/salati_setting_dark.webp",
        light: "/images/salati_setting_light.webp",
      },
    ],
  },
];

export function getProject(slug: string): Project | undefined {
  return projects.find((p) => p.slug === slug);
}
