"use client";

import { usePathname } from "next/navigation";
import { useEffect, useRef, useState } from "react";

const INTERACTIVE = "a, button, [role=tab], [role=radio], [data-cursor]";

function useFinePointer(): boolean {
  const [fine, setFine] = useState(false);
  useEffect(() => {
    const mq = window.matchMedia("(pointer: fine)");
    const update = () => setFine(mq.matches);
    update();
    mq.addEventListener("change", update);
    return () => mq.removeEventListener("change", update);
  }, []);
  return fine;
}

function prefersReducedMotion(): boolean {
  return window.matchMedia("(prefers-reduced-motion: reduce)").matches;
}

/**
 * Lime dot that tracks the pointer exactly, plus a ring that eases after it.
 * Both grow over anything clickable, and a large soft glow trails behind. Mouse/trackpad only; the native cursor
 * stays visible so nothing is lost if this fails.
 */
export function CustomCursor() {
  const fine = useFinePointer();
  const dot = useRef<HTMLDivElement>(null);
  const ring = useRef<HTMLDivElement>(null);
  const glow = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!fine || prefersReducedMotion()) return;
    const d = dot.current;
    const r = ring.current;
    const g = glow.current;
    if (!d || !r || !g) return;

    let x = -100,
      y = -100,
      rx = -100,
      ry = -100,
      gx = -100,
      gy = -100,
      raf = 0;

    const move = (e: MouseEvent) => {
      x = e.clientX;
      y = e.clientY;
      d.style.opacity = "1";
      r.style.opacity = "1";
      g.style.opacity = "1";
    };
    const leave = () => {
      d.style.opacity = "0";
      r.style.opacity = "0";
      g.style.opacity = "0";
    };
    const over = (e: MouseEvent) => {
      const hit = (e.target as Element | null)?.closest?.(INTERACTIVE);
      d.dataset.active = hit ? "1" : "";
      r.dataset.active = hit ? "1" : "";
    };
    const tick = () => {
      rx += (x - rx) * 0.18;
      ry += (y - ry) * 0.18;
      d.style.transform = `translate3d(${x}px, ${y}px, 0) translate(-50%, -50%)`;
      r.style.transform = `translate3d(${rx}px, ${ry}px, 0) translate(-50%, -50%)`;
      gx += (x - gx) * 0.08;
      gy += (y - gy) * 0.08;
      g.style.transform = `translate3d(${gx}px, ${gy}px, 0) translate(-50%, -50%)`;
      raf = requestAnimationFrame(tick);
    };

    window.addEventListener("mousemove", move);
    document.addEventListener("mouseleave", leave);
    document.addEventListener("mouseover", over);
    raf = requestAnimationFrame(tick);
    return () => {
      cancelAnimationFrame(raf);
      window.removeEventListener("mousemove", move);
      document.removeEventListener("mouseleave", leave);
      document.removeEventListener("mouseover", over);
    };
  }, [fine]);

  if (!fine) return null;
  return (
    <>
      <div ref={glow} aria-hidden className="cursor-glow" />
      <div ref={dot} aria-hidden className="cursor-dot" />
      <div ref={ring} aria-hidden className="cursor-ring" />
    </>
  );
}

/**
 * Drifting mint points joined by faint lines when close; they drift away from
 * the pointer. Density scales with screen size and caps out on big screens.
 */
export function ParticleField() {
  const canvas = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const c = canvas.current;
    const ctx = c?.getContext("2d");
    if (!c || !ctx) return;

    const reduced = prefersReducedMotion();
    let w = 0,
      h = 0,
      raf = 0,
      mx = -9999,
      my = -9999;
    let pts: { x: number; y: number; vx: number; vy: number; r: number }[] = [];

    const resize = () => {
      const dpr = Math.min(window.devicePixelRatio || 1, 2);
      w = window.innerWidth;
      h = window.innerHeight;
      c.width = w * dpr;
      c.height = h * dpr;
      c.style.width = `${w}px`;
      c.style.height = `${h}px`;
      ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
      const count = Math.min(90, Math.floor((w * h) / 24000));
      pts = Array.from({ length: count }, () => ({
        x: Math.random() * w,
        y: Math.random() * h,
        vx: (Math.random() - 0.5) * 0.25,
        vy: (Math.random() - 0.5) * 0.25,
        r: Math.random() * 1.3 + 0.5,
      }));
    };

    const LINK = 130;
    const PUSH = 20000;
    const frame = () => {
      ctx.clearRect(0, 0, w, h);
      for (const p of pts) {
        const dx = p.x - mx;
        const dy = p.y - my;
        const d2 = dx * dx + dy * dy;
        if (d2 < PUSH) {
          const f = (1 - d2 / PUSH) * 0.025;
          const len = Math.sqrt(d2) + 1;
          p.vx += (dx / len) * f;
          p.vy += (dy / len) * f;
        }
        p.x += p.vx;
        p.y += p.vy;
        p.vx *= 0.985;
        p.vy *= 0.985;
        // keep a gentle minimum drift so the field never freezes
        if (Math.abs(p.vx) < 0.05) p.vx += (Math.random() - 0.5) * 0.02;
        if (Math.abs(p.vy) < 0.05) p.vy += (Math.random() - 0.5) * 0.02;
        if (p.x < -20) p.x = w + 20;
        if (p.x > w + 20) p.x = -20;
        if (p.y < -20) p.y = h + 20;
        if (p.y > h + 20) p.y = -20;
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
        ctx.fillStyle = "rgba(107, 227, 198, 0.35)";
        ctx.fill();
      }
      ctx.lineWidth = 0.6;
      for (let i = 0; i < pts.length; i++) {
        for (let j = i + 1; j < pts.length; j++) {
          const a = pts[i];
          const b = pts[j];
          const dist = Math.hypot(a.x - b.x, a.y - b.y);
          if (dist < LINK) {
            ctx.strokeStyle = `rgba(107, 227, 198, ${(1 - dist / LINK) * 0.12})`;
            ctx.beginPath();
            ctx.moveTo(a.x, a.y);
            ctx.lineTo(b.x, b.y);
            ctx.stroke();
          }
        }
      }
      if (!reduced) raf = requestAnimationFrame(frame);
    };

    const move = (e: MouseEvent) => {
      mx = e.clientX;
      my = e.clientY;
    };
    const leave = () => {
      mx = -9999;
      my = -9999;
    };

    resize();
    frame();
    window.addEventListener("resize", resize);
    if (!reduced) {
      window.addEventListener("mousemove", move);
      document.addEventListener("mouseleave", leave);
    }
    return () => {
      cancelAnimationFrame(raf);
      window.removeEventListener("resize", resize);
      window.removeEventListener("mousemove", move);
      document.removeEventListener("mouseleave", leave);
    };
  }, []);

  return (
    <canvas
      ref={canvas}
      aria-hidden
      className="pointer-events-none fixed inset-0 -z-10"
    />
  );
}

/**
 * Soft light that follows the pointer inside cards and buttons, via the
 * --mx / --my custom properties read by the `.spotlight` CSS class.
 */
export function Spotlight() {
  const fine = useFinePointer();
  useEffect(() => {
    if (!fine) return;
    let current: HTMLElement | null = null;
    const move = (e: MouseEvent) => {
      const el = (e.target as Element | null)?.closest?.(
        ".spotlight",
      ) as HTMLElement | null;
      if (current && current !== el) {
        current.style.removeProperty("--mx");
        current.style.removeProperty("--my");
      }
      current = el;
      if (!el) return;
      const r = el.getBoundingClientRect();
      el.style.setProperty("--mx", `${e.clientX - r.left}px`);
      el.style.setProperty("--my", `${e.clientY - r.top}px`);
    };
    window.addEventListener("mousemove", move);
    return () => window.removeEventListener("mousemove", move);
  }, [fine]);
  return null;
}

/**
 * Fades sections up as they enter the viewport. Content is fully visible in
 * the HTML; the hidden starting state is only applied once JS has run, so
 * crawlers and no-JS visitors always see everything.
 */
export function Reveal() {
  const pathname = usePathname();
  useEffect(() => {
    if (prefersReducedMotion()) return;
    const els = Array.from(document.querySelectorAll<HTMLElement>("[data-reveal]"));
    const io = new IntersectionObserver(
      (entries) => {
        for (const e of entries) {
          if (e.isIntersecting) {
            e.target.classList.add("revealed");
            io.unobserve(e.target);
          }
        }
      },
      { rootMargin: "0px 0px -8% 0px", threshold: 0.08 },
    );
    for (const el of els) {
      // Leave anything already on screen alone to avoid a flash on load.
      if (el.getBoundingClientRect().top < window.innerHeight) continue;
      el.classList.add("reveal-ready");
      io.observe(el);
    }
    return () => io.disconnect();
  }, [pathname]);
  return null;
}
