import type { Metadata } from "next";
import localFont from "next/font/local";
import { site } from "@/data/site";
import {
  CustomCursor,
  ParticleField,
  Reveal,
  Spotlight,
} from "@/components/effects";
import "./globals.css";

const spaceGrotesk = localFont({
  src: [
    { path: "../fonts/SpaceGrotesk-Regular.woff2", weight: "400" },
    { path: "../fonts/SpaceGrotesk-Medium.woff2", weight: "500" },
    { path: "../fonts/SpaceGrotesk-SemiBold.woff2", weight: "600" },
    { path: "../fonts/SpaceGrotesk-Bold.woff2", weight: "700" },
  ],
  variable: "--font-space-grotesk",
  display: "swap",
});

const manrope = localFont({
  src: [
    { path: "../fonts/Manrope-Regular.woff2", weight: "400" },
    { path: "../fonts/Manrope-Medium.woff2", weight: "500" },
    { path: "../fonts/Manrope-SemiBold.woff2", weight: "600" },
    { path: "../fonts/Manrope-Bold.woff2", weight: "700" },
  ],
  variable: "--font-manrope",
  display: "swap",
});

export const metadata: Metadata = {
  metadataBase: new URL(site.url),
  title: {
    default: `${site.name} — ${site.title}`,
    template: `%s — ${site.name}`,
  },
  description: site.about,
  keywords: [
    "Flutter developer",
    "mobile software engineer",
    "Flutter",
    "Dart",
    "iOS",
    "Android",
    "cross-platform",
    "Egypt",
  ],
  authors: [{ name: site.name, url: site.url }],
  creator: site.name,
  alternates: { canonical: "/" },
  openGraph: {
    type: "website",
    url: site.url,
    siteName: site.name,
    title: `${site.name} — ${site.title}`,
    description: site.about,
    images: [{ url: "/og.png", width: 1200, height: 630, alt: `${site.name} — ${site.title}` }],
  },
  twitter: {
    card: "summary_large_image",
    title: `${site.name} — ${site.title}`,
    description: site.about,
    images: ["/og.png"],
  },
  robots: { index: true, follow: true },
};

const personJsonLd = {
  "@context": "https://schema.org",
  "@type": "Person",
  name: site.name,
  jobTitle: site.title,
  url: site.url,
  email: `mailto:${site.email}`,
  sameAs: [site.github, site.linkedin],
  knowsAbout: [...site.skills],
  worksFor: {
    "@type": "Organization",
    name: "SOAcode",
  },
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en" className={`${spaceGrotesk.variable} ${manrope.variable}`}>
      <body className="min-h-screen">
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(personJsonLd) }}
        />
        <ParticleField />
        {children}
        <CustomCursor />
        <Spotlight />
        <Reveal />
      </body>
    </html>
  );
}
