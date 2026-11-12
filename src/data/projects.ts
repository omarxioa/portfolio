import type { IconName } from "@/components/icons";

export interface ProjectScreen {
  title: string;
  icon: IconName;
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
  /** App Store link, shown when the app is live. */
  storeUrl?: string;
  /** "beta" = TestFlight; "live" = published; "coming-soon" = not yet released. */
  storeStatus: "coming-soon" | "beta" | "live";
  screens: ProjectScreen[];
}

const projectList: Project[] = [
  {
    slug: "mymed",
    order: "02",
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
    role: "Creator & Lead Flutter Developer",
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
    storeStatus: "beta",
    screens: [
      {
        title: "Today",
        icon: "home",
        subtitle: "Daily plan, reminders, and caregiver support at a glance.",
        dark: "/images/today.webp",
        light: "/images/today_light.webp",
      },
      {
        title: "Progress",
        icon: "chart",
        subtitle: "Weekly consistency, streaks, and missed-dose recovery.",
        dark: "/images/progress.webp",
        light: "/images/progress_light.webp",
      },
      {
        title: "Treatment",
        icon: "pill",
        subtitle: "Medication timelines, instructions, and refill tracking.",
        dark: "/images/treatment.webp",
        light: "/images/treatment_light.webp",
      },
      {
        title: "Support",
        icon: "support",
        subtitle: "Caregiver activity, check-ins, and shared accountability.",
        dark: "/images/support.webp",
        light: "/images/support_light.webp",
      },
    ],
  },
  {
    slug: "salati",
    order: "01",
    name: "Muslim Assistant",
    tagline: "An offline-first Islamic companion for every prayer.",
    description:
      "A bilingual (Arabic / English) Islamic companion, live on the App Store: prayer times calculated on the device, Adhan, prayer tracking, Quran, tasbih, after-prayer adhkar and a Qibla compass.",
    problem:
      "Missing prayers often happens because reminders stop working in the background or depend on internet connectivity.",
    solution:
      "Offline-first prayer reminders, full Adhan playback, accurate prayer calculations, Quran, Qibla and multilingual support.",
    impact:
      "Built as a scalable Flutter application focused on reliability, local scheduling, accessibility and distraction-free daily worship.",
    highlights: [
      "Live on the App Store",
      "Offline-first runtime with reliable prayer alerts",
      "Arabic & English, built solo from design to release",
    ],
    contributions: [
      "Engineered background-safe scheduling for prayer reminders.",
      "Integrated Quran, Qibla, and settings into one cohesive flow.",
      "Shaped interaction model for calm and focused daily usage.",
    ],
    role: "Creator & Lead Flutter Developer",
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
    storeUrl: "https://apps.apple.com/app/id6828168679",
    storeStatus: "live",
    screens: [
      {
        title: "Home",
        icon: "home",
        subtitle:
          "Prayer overview, next prayer countdown, and reliable reminders.",
        dark: "/images/salati_home_dark.webp",
        light: "/images/salati_home_light.webp",
      },
      {
        title: "Qibla",
        icon: "compass",
        subtitle: "Compass guidance designed for stable everyday use.",
        dark: "/images/salati_compass_dark.webp",
        light: "/images/salati_compass_light.webp",
      },
      {
        title: "Quran",
        icon: "book",
        subtitle: "Quick surah access with calm reading-focused navigation.",
        dark: "/images/salati_quran.webp",
        light: "/images/salati_quran_light.webp",
      },
      {
        title: "Settings",
        icon: "settings",
        subtitle:
          "Language, notifications, and prayer preferences in one place.",
        dark: "/images/salati_setting_dark.webp",
        light: "/images/salati_setting_light.webp",
      },
    ],
  },
];

/** Sorted by `order` so the live app leads. */
export const projects: Project[] = [...projectList].sort((a, b) =>
  a.order.localeCompare(b.order),
);

export function getProject(slug: string): Project | undefined {
  return projects.find((p) => p.slug === slug);
}
