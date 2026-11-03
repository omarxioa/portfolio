import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Nav } from "@/components/nav";
import { Footer } from "@/components/sections";
import { ScreenGallery } from "@/components/screen-gallery";
import {
  Badge,
  Card,
  Eyebrow,
  PrimaryLink,
  SecondaryLink,
  Tag,
} from "@/components/primitives";
import { getProject, projects } from "@/data/projects";
import { site, whatsAppInquiryUrl } from "@/data/site";

export function generateStaticParams() {
  return projects.map((p) => ({ slug: p.slug }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const project = getProject((await params).slug);
  if (!project) return {};
  return {
    title: `${project.name} — Case Study`,
    description: project.description,
    alternates: { canonical: `/projects/${project.slug}/` },
    openGraph: {
      title: `${project.name} — Case Study by ${site.name}`,
      description: project.description,
      images: [{ url: project.screens[0].dark }],
    },
  };
}

export default async function ProjectPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const project = getProject((await params).slug);
  if (!project) notFound();

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    name: project.name,
    description: project.description,
    applicationCategory: "MobileApplication",
    operatingSystem: "iOS, Android",
    author: { "@type": "Person", name: site.name, url: site.url },
  };

  return (
    <>
      <Nav />
      <main className="mx-auto max-w-6xl px-5 pb-24 pt-32">
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
        <Link href="/#work" className="text-sm text-muted hover:text-foreground">
          ← Back to work
        </Link>

        <div className="mt-8 flex flex-wrap items-center gap-4">
          <span className="font-display text-mint">{project.order}</span>
          <h1 className="font-display text-4xl font-bold sm:text-5xl">
            {project.name}
          </h1>
          {project.storeStatus === "coming-soon" ? (
            <Badge>Coming soon to the App Store &amp; Google Play</Badge>
          ) : null}
        </div>
        <p className="mt-4 max-w-2xl text-xl text-muted">{project.tagline}</p>
        <p className="mt-4 max-w-3xl text-lg leading-relaxed text-muted">
          {project.description}
        </p>
        <p className="mt-6 font-display text-sm text-muted">
          Role: {project.role} • Scope: {project.scope} • Duration:{" "}
          {project.duration}
        </p>

        <div className="mt-14 grid gap-6 md:grid-cols-3">
          <Card className="p-7">
            <Eyebrow>Problem</Eyebrow>
            <p className="mt-3 text-muted">{project.problem}</p>
          </Card>
          <Card className="p-7">
            <Eyebrow>Solution</Eyebrow>
            <p className="mt-3 text-muted">{project.solution}</p>
          </Card>
          <Card className="p-7">
            <Eyebrow>Impact</Eyebrow>
            <p className="mt-3 text-muted">{project.impact}</p>
          </Card>
        </div>

        <section className="mt-20">
          <Eyebrow>Inside the app</Eyebrow>
          <h2 className="mt-3 text-3xl font-semibold">Screens that matter</h2>
          <div className="mt-10">
            <ScreenGallery name={project.name} screens={project.screens} />
          </div>
        </section>

        <section className="mt-20 grid gap-10 lg:grid-cols-2">
          <div>
            <Eyebrow>My contribution</Eyebrow>
            <ul className="mt-5 space-y-3 text-muted">
              {project.contributions.map((c) => (
                <li key={c} className="flex gap-3">
                  <span className="mt-2.5 h-1.5 w-1.5 shrink-0 rounded-full bg-mint" />
                  <span>{c}</span>
                </li>
              ))}
            </ul>
          </div>
          <div>
            <Eyebrow>Technology</Eyebrow>
            <div className="mt-5 flex flex-wrap gap-2.5">
              {project.technologies.map((t) => (
                <Tag key={t}>{t}</Tag>
              ))}
            </div>
          </div>
        </section>

        <div className="mt-16 flex flex-wrap gap-4">
          <PrimaryLink href={whatsAppInquiryUrl(project.name)} external>
            Discuss This Project
          </PrimaryLink>
          {project.repoUrl ? (
            <SecondaryLink href={project.repoUrl} external>
              View GitHub
            </SecondaryLink>
          ) : null}
        </div>
      </main>
      <Footer />
    </>
  );
}
