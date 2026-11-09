import fs from "node:fs";
import path from "node:path";
import matter from "gray-matter";
import { remark } from "remark";
import remarkGfm from "remark-gfm";
import html from "remark-html";

const BLOG_DIR = path.join(process.cwd(), "content", "blog");

export interface PostMeta {
  slug: string;
  title: string;
  description: string;
  date: string;
  tags: string[];
  /**
   * Drafts are built and reachable by URL so they can be reviewed on a
   * preview deploy, but they are hidden from the blog index and the sitemap,
   * and marked noindex. Flip `draft: false` in the front matter to publish.
   */
  draft: boolean;
  readingMinutes: number;
}

export interface Post extends PostMeta {
  html: string;
}

function readingMinutes(text: string): number {
  return Math.max(1, Math.round(text.split(/\s+/).length / 220));
}

function readMeta(file: string): { meta: PostMeta; content: string } {
  const raw = fs.readFileSync(path.join(BLOG_DIR, file), "utf8");
  const { data, content } = matter(raw);
  return {
    meta: {
      slug: file.replace(/\.md$/, ""),
      title: String(data.title),
      description: String(data.description),
      date: String(data.date),
      tags: (data.tags as string[]) ?? [],
      draft: Boolean(data.draft),
      readingMinutes: readingMinutes(content),
    },
    content,
  };
}

function files(): string[] {
  if (!fs.existsSync(BLOG_DIR)) return [];
  return fs.readdirSync(BLOG_DIR).filter((f) => f.endsWith(".md"));
}

/** Every post, drafts included — used to generate static pages. */
export function getAllPosts(): PostMeta[] {
  return files()
    .map((f) => readMeta(f).meta)
    .sort((a, b) => (a.date < b.date ? 1 : -1));
}

/** Published posts only — used for the index and the sitemap. */
export function getPublishedPosts(): PostMeta[] {
  return getAllPosts().filter((p) => !p.draft);
}

export async function getPost(slug: string): Promise<Post | undefined> {
  const file = `${slug}.md`;
  if (!files().includes(file)) return undefined;
  const { meta, content } = readMeta(file);
  const processed = await remark().use(remarkGfm).use(html).process(content);
  return { ...meta, html: processed.toString() };
}
