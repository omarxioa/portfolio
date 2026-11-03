import Link from "next/link";
import { site } from "@/data/site";
import { getPublishedPosts } from "@/lib/blog";

export function Nav() {
  // The Blog link appears automatically once the first post is published.
  const hasPosts = getPublishedPosts().length > 0;
  const links = [
    { href: "/#work", label: "Work" },
    { href: "/#experience", label: "Experience" },
    ...(hasPosts ? [{ href: "/blog/", label: "Blog" }] : []),
    { href: "/#contact", label: "Contact" },
  ];

  return (
    <header className="fixed inset-x-0 top-0 z-50 border-b border-white/10 bg-background/80 backdrop-blur-md">
      <nav className="mx-auto flex h-16 max-w-6xl items-center justify-between px-5">
        <Link
          href="/"
          className="font-display text-lg font-bold tracking-tight"
        >
          omar<span className="text-lime">.</span>dev
        </Link>
        <div className="flex items-center gap-1 sm:gap-2">
          {links.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className="rounded-md px-2.5 py-2 text-sm text-muted transition-colors hover:text-foreground sm:px-3"
            >
              {link.label}
            </Link>
          ))}
          <a
            href={site.cvPath}
            target="_blank"
            rel="noopener noreferrer"
            className="ml-1 hidden h-9 items-center rounded-lg bg-lime px-4 font-display text-sm font-semibold text-background transition-colors hover:bg-lime/85 sm:inline-flex"
          >
            Resume
          </a>
        </div>
      </nav>
    </header>
  );
}
