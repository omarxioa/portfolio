# omarabdelnaby.dev

Personal portfolio of Omar Abdelnaby — Mobile Software Engineer.

Built with **Next.js (App Router) + Tailwind CSS**, exported as a fully static site and deployed to **Cloudflare Pages** by `.github/workflows/deploy.yml` on every push to `main`.

Every page is pre-rendered HTML, so search engines and link previews see the full content (the previous Flutter Web build shipped an empty shell that crawlers couldn't read).

## Develop

```bash
npm install
npm run dev     # http://localhost:3000
npm run build   # static export to ./out
```

## Where to edit content

| What | File |
| --- | --- |
| Name, links, hero copy, about, skills, experience | `src/data/site.ts` |
| Projects / case studies (myMed, Salati) | `src/data/projects.ts` |
| Project screenshots | `public/images/` |
| Resume PDF | `public/cv/Omar-cv.pdf` |
| Blog posts | `content/blog/*.md` |

### Publishing a blog post

Posts are Markdown files with front matter. A post with `draft: true` is built and reachable at `/blog/<slug>/` for review, but is hidden from the blog index and sitemap and marked `noindex`. Change it to `draft: false` to publish. The "Blog" link in the nav appears automatically once at least one post is published.

### When the apps go live on the stores

In `src/data/projects.ts`, change `storeStatus` from `"coming-soon"` to `"live"` for that project (and add store links to the case-study page).

## SEO

- Per-page `<title>`, description, canonical URL, Open Graph and Twitter tags
- JSON-LD: `Person` (site-wide), `SoftwareApplication` (case studies), `BlogPosting` (articles)
- `sitemap.xml` and `robots.txt` generated at build time
