"use client";

import Image from "next/image";
import { useRef, useState } from "react";
import type { ProjectScreen } from "@/data/projects";
import { Icon } from "./icons";

/**
 * Phone preview ported from the Flutter selected-work card: a Dark/Light
 * segmented switch above the phone, the active screen's name and subtitle
 * below it, and the app's own nav icons to move between screens.
 *
 * Every screen's image is stacked and cross-faded, so switching is instant
 * after first load. Arrow keys and horizontal swipes also navigate. All
 * titles and subtitles are in the HTML for crawlers and screen readers.
 */
export function ScreenGallery({
  name,
  screens,
  priority = false,
  rtl = false,
}: {
  name: string;
  screens: ProjectScreen[];
  priority?: boolean;
  /** Lay the nav buttons out right-to-left, matching an Arabic app's tab bar. */
  rtl?: boolean;
}) {
  const [active, setActive] = useState(0);
  const [light, setLight] = useState(true);
  const touchX = useRef<number | null>(null);
  const screen = screens[active];

  const go = (delta: number) =>
    setActive((i) => (i + delta + screens.length) % screens.length);

  return (
    <div
      className="flex flex-col items-center outline-none"
      tabIndex={0}
      aria-label={`${name} screen preview. Use left and right arrow keys to change screens.`}
      onKeyDown={(e) => {
        if (e.key === "ArrowRight") go(rtl ? -1 : 1);
        if (e.key === "ArrowLeft") go(rtl ? 1 : -1);
      }}
    >
      {/* Dark / Light segmented switch */}
      <div
        className="inline-flex rounded-full border border-white/10 bg-surface p-1"
        role="radiogroup"
        aria-label="Preview theme"
      >
        {(
          [
            { value: true, label: "Light", icon: "sun" },
            { value: false, label: "Dark", icon: "moon" },
          ] as const
        ).map((opt) => {
          const selected = light === opt.value;
          return (
            <button
              key={opt.label}
              type="button"
              role="radio"
              aria-checked={selected}
              onClick={() => setLight(opt.value)}
              className={`inline-flex items-center gap-1.5 rounded-full px-4 py-1.5 font-display text-sm font-semibold transition-colors ${
                selected
                  ? "bg-lime/15 text-lime"
                  : "text-muted hover:text-foreground"
              }`}
            >
              <Icon name={opt.icon} className="h-4 w-4" />
              {opt.label}
            </button>
          );
        })}
      </div>

      {/* Phone */}
      <div
        className="mt-6 w-full max-w-[230px] rounded-[2.2rem] sm:max-w-[290px] sm:rounded-[2.4rem] border border-white/10 bg-elevated p-2.5 shadow-[0_30px_80px_-20px_rgba(0,0,0,0.8)]"
        onTouchStart={(e) => (touchX.current = e.touches[0].clientX)}
        onTouchEnd={(e) => {
          if (touchX.current === null) return;
          const dx = e.changedTouches[0].clientX - touchX.current;
          if (Math.abs(dx) > 40) go((dx < 0) !== rtl ? 1 : -1);
          touchX.current = null;
        }}
      >
        <div className="relative aspect-[9/19.5] overflow-hidden rounded-[1.8rem] bg-background sm:rounded-[2rem]">
          {screens.map((s, i) =>
            (["dark", "light"] as const).map((mode) => {
              const visible = i === active && (mode === "light") === light;
              return (
                <Image
                  key={`${s.title}-${mode}`}
                  src={s[mode]}
                  alt={visible ? `${name} — ${s.title} screen (${mode} mode)` : ""}
                  aria-hidden={!visible}
                  fill
                  sizes="290px"
                  priority={priority && i === 0 && mode === "dark"}
                  className={`object-cover object-top transition-opacity duration-300 ${
                    visible ? "opacity-100" : "opacity-0"
                  }`}
                />
              );
            }),
          )}
        </div>
      </div>

      {/* Active screen caption */}
      <div className="mt-4 min-h-[4.5rem] text-center" aria-live="polite">
        <p className="font-display text-lg font-semibold">{screen.title}</p>
        <p className="mx-auto mt-1 max-w-[290px] text-sm text-muted">
          {screen.subtitle}
        </p>
      </div>

      {/* App nav icons */}
      <div
        className="mt-3 flex gap-2.5"
        role="tablist"
        aria-label="Screens"
        dir={rtl ? "rtl" : undefined}
      >
        {screens.map((s, i) => {
          const selected = i === active;
          return (
            <button
              key={s.title}
              type="button"
              role="tab"
              aria-selected={selected}
              aria-label={s.title}
              title={s.title}
              onClick={() => setActive(i)}
              className={`flex h-11 w-12 items-center sm:h-12 sm:w-14 justify-center rounded-full border transition-colors ${
                selected
                  ? "border-lime/40 bg-lime/15 text-lime"
                  : "border-white/10 bg-surface text-muted hover:border-white/30 hover:text-foreground"
              }`}
            >
              <Icon name={s.icon} />
            </button>
          );
        })}
      </div>

      {/* Full list for crawlers and screen readers. */}
      <ul className="sr-only">
        {screens.map((s) => (
          <li key={s.title}>
            {s.title}: {s.subtitle}
          </li>
        ))}
      </ul>
    </div>
  );
}
