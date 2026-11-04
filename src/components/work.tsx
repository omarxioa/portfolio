import Link from "next/link";
import { projects } from "@/data/projects";
import { Badge, Card, SectionHeading, Tag } from "./primitives";
import { ScreenGallery } from "./screen-gallery";

export function SelectedWork() {
  return (
    <section className="mx-auto max-w-6xl px-5 py-24">
      <SectionHeading
        id="work"
        eyebrow="Selected Work"
        title="Featured Personal Projects"
        subtitle="A curated selection of products I've designed and developed."
      />
      <div className="mt-12 space-y-8">
        {projects.map((project) => (
          <Card key={project.slug} className="overflow-hidden">
            <div className="grid gap-8 p-7 sm:p-10 lg:grid-cols-[1fr_340px] lg:items-center">
              <div>
                <div className="flex items-center gap-3">
                  <span className="font-display text-sm text-mint">
                    {project.order}
                  </span>
                  <h3 className="font-display text-3xl font-semibold">
                    {project.name}
                  </h3>
                  {project.storeStatus === "coming-soon" ? (
                    <Badge>Coming soon to stores</Badge>
                  ) : null}
                </div>
                <p className="mt-4 text-lg text-muted">{project.description}</p>
                <ul className="mt-6 space-y-2 text-muted">
                  {project.highlights.map((h) => (
                    <li key={h} className="flex gap-3">
                      <span className="mt-2.5 h-1.5 w-1.5 shrink-0 rounded-full bg-mint" />
                      <span>{h}</span>
                    </li>
                  ))}
                </ul>
                <div className="mt-6 flex flex-wrap gap-2">
                  {project.technologies.slice(0, 4).map((t) => (
                    <Tag key={t}>{t}</Tag>
                  ))}
                </div>
                <Link
                  href={`/projects/${project.slug}/`}
                  className="mt-8 inline-flex h-12 items-center rounded-lg bg-lime px-6 font-display text-sm font-semibold text-background transition-colors hover:bg-lime/85"
                >
                  Read the case study →
                </Link>
              </div>
              <ScreenGallery name={project.name} screens={project.screens} />
            </div>
          </Card>
        ))}
      </div>
    </section>
  );
}
