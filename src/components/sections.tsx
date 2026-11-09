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
    <section data-reveal className="mx-auto max-w-6xl px-5 py-14 sm:py-20">
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
    <section data-reveal className="mx-auto max-w-6xl px-5 py-14 sm:py-20">
      <SectionHeading
        id="experience"
        eyebrow="Experience"
        title="Where I've worked"
      />
      <ol className="relative mt-12 border-l border-white/10 pl-8 sm:pl-10">
        {experiences.map((exp, i) => (
          <li key={exp.company} className={i === 0 ? "" : "mt-14"}>
            <span
              className={`absolute -left-[7px] mt-1.5 h-3.5 w-3.5 rounded-full border-2 border-background ${
                i === 0 ? "bg-mint shadow-[0_0_0_4px_rgba(107,227,198,0.15)]" : "bg-white/30"
              }`}
              aria-hidden
            />
            <p className="font-display text-sm text-muted">{exp.duration}</p>
            <h3 className="mt-2 text-xl font-semibold sm:text-2xl">
              {exp.role}
            </h3>
            <p className="mt-1 text-mint">{exp.company}</p>
            <ul className="mt-5 max-w-3xl space-y-3 text-muted">
              {exp.achievements.map((a) => (
                <li key={a} className="flex gap-3">
                  <span className="mt-2.5 h-1.5 w-1.5 shrink-0 rounded-full bg-white/30" />
                  <span>{a}</span>
                </li>
              ))}
            </ul>
            <div className="mt-5 flex flex-wrap gap-2">
              {exp.technologies.map((t) => (
                <Tag key={t}>{t}</Tag>
              ))}
            </div>
          </li>
        ))}
      </ol>
    </section>
  );
}

export function Contact() {
  return (
    <section data-reveal className="mx-auto max-w-6xl px-5 py-14 sm:py-20">
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
        <div className="mx-auto mt-8 grid max-w-sm gap-3 sm:flex sm:max-w-none sm:flex-wrap sm:justify-center sm:gap-4">
          <PrimaryLink href={whatsAppUrl()} external className="w-full sm:w-auto">
            WhatsApp Me
          </PrimaryLink>
          <SecondaryLink href={mailtoUrl()} external className="w-full sm:w-auto">
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
