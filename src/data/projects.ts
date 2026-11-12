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
        subtitle: "Today's adherence, the next dose, and every dose of the day.",
        dark: "/images/mymed_today_dark.webp",
        light: "/images/mymed_today_light.webp",
      },
      {
        title: "Progress",
        icon: "chart",
        subtitle: "Weekly to 3-month adherence, streaks, and daily trends.",
        dark: "/images/mymed_progress_dark.webp",
        light: "/images/mymed_progress_light.webp",
      },
      {
        title: "Medications",
        icon: "pill",
        subtitle: "Active medications with remaining stock and refill timing.",
        dark: "/images/mymed_medications_dark.webp",
        light: "/images/mymed_medications_light.webp",
      },
      {
        title: "Add medication",
        icon: "plus",
        subtitle: "Guided setup that pulls type and strength from a drug list.",
        dark: "/images/mymed_add_dark.webp",
        light: "/images/mymed_add_light.webp",
      },
      {
        title: "Family",
        icon: "support",
        subtitle: "A care circle: share an invite code so family can follow along.",
        dark: "/images/mymed_family_dark.webp",
        light: "/images/mymed_family_light.webp",
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
      "Integrated Quran, Qibla, and tasbih into one cohesive flow.",
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
          "Next prayer countdown, Hijri date, daily summary, and missed-prayer tracking.",
        dark: "/images/muslim_assistant_home_dark.webp",
        light: "/images/muslim_assistant_home_light.webp",
      },
      {
        title: "Qibla",
        icon: "compass",
        subtitle: "Compass that confirms when you are facing the Kaaba.",
        dark: "/images/muslim_assistant_qibla_dark.webp",
        light: "/images/muslim_assistant_qibla_light.webp",
      },
      {
        title: "Quran",
        icon: "book",
        subtitle: "Search, every surah, and continue reading where you left off.",
        dark: "/images/muslim_assistant_quran_dark.webp",
        light: "/images/muslim_assistant_quran_light.webp",
      },
      {
        title: "Tasbih",
        icon: "tap",
        subtitle: "Tap anywhere to count, swipe to move between adhkar.",
        dark: "/images/muslim_assistant_tasbih_dark.webp",
        light: "/images/muslim_assistant_tasbih_light.webp",
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
