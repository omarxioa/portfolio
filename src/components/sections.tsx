import { site, experiences, mailtoUrl, whatsAppUrl } from "@/data/site";
import {
  Card,
  PrimaryLink,
  SecondaryLink,
  SectionHeading,
  Tag,
} from "./primitives";

export function About() {
  return (
    <section className="mx-auto max-w-6xl px-5 py-24">
      <SectionHeading
        id="about"
        eyebrow="About"
        title="Product clarity, implementation quality."
      />
      <div className="mt-10 grid gap-10 lg:grid-cols-[3fr_2fr]">
        <div className="space-y-5 text-lg leading-relaxed text-muted">
          <p>{site.about}</p>
          <ul className="space-y-3">
            {site.notes.map((note) => (
              <li key={note} className="flex gap-3">
                <span className="mt-2.5 h-1.5 w-1.5 shrink-0 rounded-full bg-mint" />
                <span>{note}</span>
              </li>
            ))}
          </ul>
        </div>
        <div>
          <h3 className="font-display text-sm font-medium uppercase tracking-[0.25em] text-mint">
            Skills
          </h3>
          <div className="mt-4 flex flex-wrap gap-2.5">
            {site.skills.map((skill) => (
              <Tag key={skill}>{skill}</Tag>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}

export function Experience() {
  return (
    <section className="mx-auto max-w-6xl px-5 py-24">
      <SectionHeading
        id="experience"
        eyebrow="Experience"
        title="Where I've worked"
      />
      <div className="mt-12 space-y-6">
        {experiences.map((exp) => (
          <Card key={exp.company} className="p-7 sm:p-9">
            <div className="flex flex-wrap items-baseline justify-between gap-2">
              <div>
                <h3 className="text-xl font-semibold">{exp.role}</h3>
                <p className="mt-1 text-mint">{exp.company}</p>
              </div>
              <p className="font-display text-sm text-muted">{exp.duration}</p>
            </div>
            <ul className="mt-6 space-y-3 text-muted">
              {exp.achievements.map((a) => (
                <li key={a} className="flex gap-3">
                  <span className="mt-2.5 h-1.5 w-1.5 shrink-0 rounded-full bg-mint" />
                  <span>{a}</span>
                </li>
              ))}
            </ul>
            <div className="mt-6 flex flex-wrap gap-2">
              {exp.technologies.map((t) => (
                <Tag key={t}>{t}</Tag>
              ))}
            </div>
          </Card>
        ))}
      </div>
    </section>
  );
}

export function Contact() {
  return (
    <section className="mx-auto max-w-6xl px-5 py-24">
      <Card className="p-10 text-center sm:p-16">
        <SectionHeading
          id="contact"
          eyebrow="Contact"
          title="Let's build something reliable."
        />
        <p className="mx-auto mt-4 max-w-xl text-muted">
          Have a product in mind, or a Flutter codebase that needs a steady
          hand? I reply fastest on WhatsApp.
        </p>
        <div className="mt-8 flex flex-wrap justify-center gap-4">
          <PrimaryLink href={whatsAppUrl()} external>
            WhatsApp Me
          </PrimaryLink>
          <SecondaryLink href={mailtoUrl()} external>
            {site.email}
          </SecondaryLink>
        </div>
      </Card>
    </section>
  );
}

export function Footer() {
  return (
    <footer className="border-t border-white/10">
      <div className="mx-auto flex max-w-6xl flex-wrap items-center justify-between gap-4 px-5 py-8 text-sm text-muted">
        <p>
          © {new Date().getFullYear()} {site.name}. Built with Next.js.
        </p>
        <div className="flex gap-5">
          <a
            href={site.github}
            target="_blank"
            rel="noopener noreferrer"
            className="transition-colors hover:text-foreground"
          >
            GitHub
          </a>
          <a
            href={site.linkedin}
            target="_blank"
            rel="noopener noreferrer"
            className="transition-colors hover:text-foreground"
          >
            LinkedIn
          </a>
          <a
            href={site.cvPath}
            target="_blank"
            rel="noopener noreferrer"
            className="transition-colors hover:text-foreground"
          >
            Resume
          </a>
        </div>
      </div>
    </footer>
  );
}
