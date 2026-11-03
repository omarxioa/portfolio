"use client";

import { useEffect, useState } from "react";
import { site, mailtoUrl, whatsAppUrl } from "@/data/site";
import { PrimaryLink, SecondaryLink } from "./primitives";

/**
 * Typing effect ported from the Flutter hero. Content is rendered server-side
 * in full for crawlers inside a visually-hidden element; the animation is a
 * progressive enhancement on top.
 */
function TypingLine() {
  const phrases = site.heroTypingPhrases;
  const [phraseIndex, setPhraseIndex] = useState(0);
  const [length, setLength] = useState(0);
  const [deleting, setDeleting] = useState(false);

  useEffect(() => {
    const phrase = phrases[phraseIndex];
    const timeout = setTimeout(
      () => {
        if (!deleting) {
          if (length < phrase.length) setLength(length + 1);
          else setTimeout(() => setDeleting(true), 1400);
        } else {
          if (length > 0) setLength(length - 1);
          else {
            setDeleting(false);
            setPhraseIndex((phraseIndex + 1) % phrases.length);
          }
        }
      },
      deleting ? 35 : 65,
    );
    return () => clearTimeout(timeout);
  }, [length, deleting, phraseIndex, phrases]);

  return (
    <p className="font-display text-lg text-mint sm:text-xl" aria-hidden>
      {site.heroTypingPrefix}
      {phrases[phraseIndex].slice(0, length)}
      <span className="animate-pulse">|</span>
    </p>
  );
}

export function Hero() {
  return (
    <section className="hero-glow relative flex min-h-[92vh] items-center pt-16">
      <div className="mx-auto w-full max-w-6xl px-5 py-20">
        <span className="inline-flex items-center gap-2 rounded-full border border-white/15 bg-surface px-4 py-1.5 text-sm text-muted">
          <span className="h-2 w-2 rounded-full bg-lime" />
          {site.availability}
        </span>
        <p className="mt-8 font-display text-xl text-muted sm:text-2xl">
          {site.heroGreeting}
        </p>
        <h1 className="mt-3 font-display text-5xl font-bold leading-[1.05] tracking-tight sm:text-7xl">
          {site.heroRole[0]}
          <br />
          <span className="text-lime">{site.heroRole[1]}</span>
        </h1>
        <div className="mt-6">
          <TypingLine />
          {/* Full text for crawlers and screen readers. */}
          <span className="sr-only">
            {site.heroTypingPrefix}
            {site.heroTypingPhrases.join(" ")}
          </span>
        </div>
        <p className="mt-8 max-w-xl text-base leading-relaxed text-muted sm:text-lg">
          {site.heroSummary}
        </p>
        <div className="mt-10 flex flex-wrap gap-4">
          <PrimaryLink href={whatsAppUrl()} external>
            Let&apos;s Talk
          </PrimaryLink>
          <SecondaryLink href="/#work">View My Work</SecondaryLink>
          <SecondaryLink href={mailtoUrl()} external>
            Email Me
          </SecondaryLink>
        </div>
      </div>
    </section>
  );
}
