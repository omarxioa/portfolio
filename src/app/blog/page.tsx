import type { Metadata } from "next";
import Link from "next/link";
import { Nav } from "@/components/nav";
import { Footer } from "@/components/sections";
import { Eyebrow, Tag } from "@/components/primitives";
import { getPublishedPosts } from "@/lib/blog";
import { site } from "@/data/site";

export const metadata: Metadata = {
  title: "Blog",
  description: `Notes on Flutter, offline-first apps, and shipping reliable mobile products, by ${site.name}.`,
  alternates: { canonical: "/blog/" },
};

function formatDate(date: string) {
  return new Date(date).toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}

export default function BlogIndex() {
  const posts = getPublishedPosts();
  return (
    <>
      <Nav />
      <main className="mx-auto max-w-3xl px-5 pb-24 pt-32">
        <Eyebrow>Blog</Eyebrow>
        <h1 className="mt-3 font-display text-4xl font-bold sm:text-5xl">
          Notes from shipping mobile apps
        </h1>
        <p className="mt-4 text-lg text-muted">
          Flutter, offline-first data, reliable notifications, and the
          architecture decisions behind them.
        </p>

        {posts.length === 0 ? (
          <p className="mt-16 text-muted">First articles are on the way.</p>
        ) : (
          <ul className="mt-14 divide-y divide-white/10">
            {posts.map((post) => (
              <li key={post.slug} className="py-8">
                <Link href={`/blog/${post.slug}/`} className="group block">
                  <p className="font-display text-sm text-muted">
                    {formatDate(post.date)} · {post.readingMinutes} min read
                  </p>
                  <h2 className="mt-2 text-2xl font-semibold transition-colors group-hover:text-lime">
                    {post.title}
                  </h2>
                  <p className="mt-3 text-muted">{post.description}</p>
                  <div className="mt-4 flex flex-wrap gap-2">
                    {post.tags.map((t) => (
                      <Tag key={t}>{t}</Tag>
                    ))}
                  </div>
                </Link>
              </li>
            ))}
          </ul>
        )}
      </main>
      <Footer />
    </>
  );
}
