"use client";

import { useEffect, useState } from "react";
import { site, mailtoUrl, whatsAppUrl } from "@/data/site";
import { PrimaryLink, SecondaryLink } from "./primitives";

// Timings ported from the Flutter _CalmTypingLine.
const TYPE_MS = 78;
const DELETE_MS = 40;
const PAUSE_AFTER_TYPE_MS = 1800;
const PAUSE_BEFORE_TYPE_MS = 420;
const START_DELAY_MS = 700;

/**
 * "Building <phrase>" with the phrase typed out in lime. The full set of
 * phrases is rendered server-side in a visually hidden element for crawlers
 * and screen readers; the animation is a progressive enhancement on top.
 */
function TypingLine() {
  const phrases = site.heroTypingPhrases;
  const [phraseIndex, setPhraseIndex] = useState(0);
  const [count, setCount] = useState(0);
  const [deleting, setDeleting] = useState(false);
  const [started, setStarted] = useState(false);

  useEffect(() => {
    const t = setTimeout(() => setStarted(true), START_DELAY_MS);
    return () => clearTimeout(t);
  }, []);

  useEffect(() => {
    if (!started) return;
    const phrase = phrases[phraseIndex];
    let delay: number;
    let next: () => void;

    if (!deleting) {
      if (count < phrase.length) {
        delay = TYPE_MS;
        next = () => setCount((c) => c + 1);
      } else {
        delay = PAUSE_AFTER_TYPE_MS;
        next = () => setDeleting(true);
      }
    } else if (count > 0) {
      delay = DELETE_MS;
      next = () => setCount((c) => c - 1);
    } else {
      delay = PAUSE_BEFORE_TYPE_MS;
      next = () => {
        setDeleting(false);
        setPhraseIndex((i) => (i + 1) % phrases.length);
      };
    }

    const t = setTimeout(next, delay);
    return () => clearTimeout(t);
  }, [started, count, deleting, phraseIndex, phrases]);

  return (
    <p
      className="min-h-[2.6em] font-display text-2xl font-medium leading-[1.26] sm:text-[28px] xl:text-[32px]"
      aria-hidden
    >
      {site.heroTypingPrefix}
      <span className="text-lime">
        {phrases[phraseIndex].slice(0, count)}
      </span>
      <span className="animate-[blink_1.12s_steps(1)_infinite] text-muted">
        |
      </span>
    </p>
  );
}

export function Hero() {
  return (
    <section className="hero-glow relative flex min-h-[92vh] items-center pt-16">
      <div className="mx-auto w-full max-w-6xl px-5 py-20">
        <div className="max-w-[920px]">
          <span className="inline-flex items-center gap-2 rounded-full bg-white/5 px-3.5 py-1.5 text-sm font-medium">
            <span className="h-1.5 w-1.5 rounded-full bg-lime" />
            {site.availability}
          </span>

          <h1 className="mt-6 font-display">
            <span className="block text-[46px] font-bold leading-[0.98] tracking-tight min-[900px]:text-[60px] min-[1100px]:text-[68px] min-[1400px]:text-[76px]">
              {site.heroGreeting}
            </span>
            <span className="mt-1 block text-4xl font-extrabold leading-[0.95] tracking-tight min-[900px]:text-[40px] min-[1100px]:text-[44px] min-[1400px]:text-[50px]">
              {site.heroRole[0]}
              <br />
              {site.heroRole[1]}
            </span>
          </h1>

          <div className="mt-8">
            <TypingLine />
            {/* Full text for crawlers and screen readers. */}
            <p className="sr-only">
              {site.heroTypingPrefix}
              {site.heroTypingPhrases.join(" ")}
            </p>
          </div>

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
      </div>
    </section>
  );
}
