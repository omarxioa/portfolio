import { projects } from "@/data/projects";
import { ArrowLink, Badge, Card, SectionHeading, Tag } from "./primitives";
import { ScreenGallery } from "./screen-gallery";

export function SelectedWork() {
  return (
    <section className="mx-auto max-w-6xl px-5 py-14 sm:py-20">
      <SectionHeading
        id="work"
        eyebrow="Selected Work"
        title="Featured Personal Projects"
        subtitle="A curated selection of products I've designed and developed."
      />
      <div className="mt-12 space-y-8">
        {projects.map((project) => (
          <Card key={project.slug} className="overflow-hidden" data-reveal>
            <div className="grid gap-8 p-7 sm:p-10 lg:grid-cols-[1fr_340px] lg:items-center">
              <div>
                <div className="flex items-center gap-3">
                  <span className="font-display text-sm text-mint">
                    {project.order}
                  </span>
                  <h3 className="font-display text-3xl font-semibold">
                    {project.name}
                  </h3>
                  {project.storeStatus === "live" ? (
                    <Badge>Live on the App Store</Badge>
                  ) : project.storeStatus === "beta" ? (
                    <Badge>In beta on TestFlight</Badge>
                  ) : (
                    <Badge>Coming soon to stores</Badge>
                  )}
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
                <div className="mt-8 flex flex-wrap items-center gap-x-8 gap-y-3">
                  <ArrowLink href={`/projects/${project.slug}/`}>
                    Read the case study
                  </ArrowLink>
                  {project.storeStatus === "live" && project.storeUrl ? (
                    <a
                      href={project.storeUrl}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="font-display text-sm font-semibold text-mint hover:underline"
                    >
                      View on the App Store ↗
                    </a>
                  ) : null}
                </div>
              </div>
              <ScreenGallery name={project.name} screens={project.screens} />
            </div>
          </Card>
        ))}
      </div>
    </section>
  );
}
