import Link from "next/link";
import type { ReactNode } from "react";

export function Eyebrow({ children }: { children: ReactNode }) {
  return (
    <p className="font-display text-sm font-medium uppercase tracking-[0.25em] text-mint">
      {children}
    </p>
  );
}

export function SectionHeading({
  eyebrow,
  title,
  subtitle,
  id,
}: {
  eyebrow: string;
  title: string;
  subtitle?: string;
  id?: string;
}) {
  return (
    <div id={id} className="scroll-mt-28">
      <Eyebrow>{eyebrow}</Eyebrow>
      <h2 className="mt-3 text-3xl font-semibold sm:text-4xl">{title}</h2>
      {subtitle ? (
        <p className="mt-3 max-w-2xl text-base text-muted">{subtitle}</p>
      ) : null}
    </div>
  );
}

export function Tag({ children }: { children: ReactNode }) {
  return (
    <span className="inline-flex items-center rounded-full border border-white/20 bg-surface px-3 py-1 text-sm text-foreground/90">
      {children}
    </span>
  );
}

export function Badge({ children }: { children: ReactNode }) {
  return (
    <span className="inline-flex items-center gap-1.5 rounded-full border border-mint/30 bg-mint/10 px-3 py-1 text-xs font-medium text-mint">
      {children}
    </span>
  );
}

const buttonBase =
  "inline-flex h-12 sm:min-w-[150px] items-center justify-center gap-2 rounded-lg px-5 font-display text-sm font-semibold transition-colors";

export function PrimaryLink({
  href,
  children,
  external,
  className = "",
}: {
  href: string;
  children: ReactNode;
  external?: boolean;
  className?: string;
}) {
  return (
    <a
      href={href}
      {...(external ? { target: "_blank", rel: "noopener noreferrer" } : {})}
      className={`${buttonBase} bg-lime text-background hover:bg-lime/85 ${className}`}
    >
      {children}
    </a>
  );
}

export function SecondaryLink({
  href,
  children,
  external,
  className: extra = "",
}: {
  href: string;
  children: ReactNode;
  external?: boolean;
  className?: string;
}) {
  const className = `${buttonBase} border border-white/25 text-foreground hover:border-white/60 hover:bg-white/5 ${extra}`;
  if (external) {
    return (
      <a
        href={href}
        target="_blank"
        rel="noopener noreferrer"
        className={className}
      >
        {children}
      </a>
    );
  }
  return (
    <Link href={href} className={className}>
      {children}
    </Link>
  );
}

export function Card({
  children,
  className = "",
}: {
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={`rounded-2xl border border-white/10 bg-surface/80 backdrop-blur-sm ${className}`}
    >
      {children}
    </div>
  );
}

export function ArrowLink({ href, children }: { href: string; children: ReactNode }) {
  return (
    <Link
      href={href}
      className="group inline-flex items-center gap-2 font-display text-sm font-semibold text-foreground underline-offset-4 hover:underline"
    >
      {children}
      <span className="transition-transform group-hover:translate-x-1" aria-hidden>
        →
      </span>
    </Link>
  );
}
