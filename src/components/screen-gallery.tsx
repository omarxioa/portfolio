"use client";

import Image from "next/image";
import { useState } from "react";
import type { ProjectScreen } from "@/data/projects";

/**
 * Interactive phone-screen gallery for case-study pages: tab between screens
 * and flip dark/light mode, ported from the Flutter selected-work card. All
 * screen titles and subtitles are rendered as real HTML for crawlers.
 */
export function ScreenGallery({
  name,
  screens,
}: {
  name: string;
  screens: ProjectScreen[];
}) {
  const [active, setActive] = useState(0);
  const [light, setLight] = useState(false);
  const screen = screens[active];

  return (
    <div className="grid items-center gap-10 lg:grid-cols-2">
      <div className="relative mx-auto w-full max-w-[300px]">
        <div className="rounded-[2.2rem] border border-white/15 bg-elevated p-2 shadow-2xl">
          <Image
            src={light ? screen.light : screen.dark}
            alt={`${name} — ${screen.title} screen (${light ? "light" : "dark"} mode)`}
            width={300}
            height={620}
            className="w-full rounded-[1.8rem]"
            priority
          />
        </div>
        <button
          type="button"
          onClick={() => setLight(!light)}
          className="absolute -right-3 top-6 rounded-full border border-white/20 bg-surface px-3 py-1.5 text-xs text-foreground transition-colors hover:border-white/50"
          aria-label="Toggle light and dark preview"
        >
          {light ? "🌙 Dark" : "☀️ Light"}
        </button>
      </div>
      <div>
        <div className="flex flex-wrap gap-2" role="tablist">
          {screens.map((s, i) => (
            <button
              key={s.title}
              type="button"
              role="tab"
              aria-selected={i === active}
              onClick={() => setActive(i)}
              className={`rounded-full border px-4 py-2 font-display text-sm transition-colors ${
                i === active
                  ? "border-lime bg-lime text-background"
                  : "border-white/20 text-muted hover:border-white/50 hover:text-foreground"
              }`}
            >
              {s.title}
            </button>
          ))}
        </div>
        <ul className="mt-8 space-y-5">
          {screens.map((s, i) => (
            <li
              key={s.title}
              className={i === active ? "" : "opacity-50"}
            >
              <h3 className="font-display font-semibold">{s.title}</h3>
              <p className="mt-1 text-muted">{s.subtitle}</p>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
