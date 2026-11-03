import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Nav } from "@/components/nav";
import { Footer } from "@/components/sections";
import { Tag } from "@/components/primitives";
import { getAllPosts, getPost } from "@/lib/blog";
import { site } from "@/data/site";

export function generateStaticParams() {
  return getAllPosts().map((p) => ({ slug: p.slug }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const post = await getPost((await params).slug);
  if (!post) return {};
  return {
    title: post.title,
    description: post.description,
    alternates: { canonical: `/blog/${post.slug}/` },
    robots: post.draft ? { index: false, follow: false } : undefined,
    openGraph: {
      type: "article",
      title: post.title,
      description: post.description,
      publishedTime: post.date,
      authors: [site.name],
    },
  };
}

export default async function BlogPost({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const post = await getPost((await params).slug);
  if (!post) notFound();

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "BlogPosting",
    headline: post.title,
    description: post.description,
    datePublished: post.date,
    author: { "@type": "Person", name: site.name, url: site.url },
    mainEntityOfPage: `${site.url}/blog/${post.slug}/`,
  };

  return (
    <>
      <Nav />
      <main className="mx-auto max-w-3xl px-5 pb-24 pt-32">
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
        <Link href="/blog/" className="text-sm text-muted hover:text-foreground">
          ← All articles
        </Link>
        {post.draft ? (
          <p className="mt-6 rounded-lg border border-lime/40 bg-lime/10 px-4 py-3 text-sm text-lime">
            Draft — hidden from the blog index, the sitemap, and search
            engines until published.
          </p>
        ) : null}
        <article>
          <header className="mt-8">
            <p className="font-display text-sm text-muted">
              {new Date(post.date).toLocaleDateString("en-US", {
                year: "numeric",
                month: "long",
                day: "numeric",
              })}{" "}
              · {post.readingMinutes} min read
            </p>
            <h1 className="mt-3 font-display text-3xl font-bold leading-tight sm:text-4xl">
              {post.title}
            </h1>
            <div className="mt-5 flex flex-wrap gap-2">
              {post.tags.map((t) => (
                <Tag key={t}>{t}</Tag>
              ))}
            </div>
          </header>
          <div
            className="prose-dark mt-10"
            dangerouslySetInnerHTML={{ __html: post.html }}
          />
        </article>
      </main>
      <Footer />
    </>
  );
}
