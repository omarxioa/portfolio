# Omar Abdelnaby — Portfolio

Personal portfolio built with Flutter Web. Live at
**[omarabdelnaby.dev](https://omarabdelnaby.dev)**.

A single scrolling page: hero, about and stack, two case studies with
interactive device previews, experience, and contact.

## Architecture

```
lib/
  core/
    constants/    AppData — every piece of site copy lives here, not in widgets
    theme/        ThemeData plus design tokens (space, radius, breakpoints, motion)
    widgets/      Layout primitives and shared pieces (AppSection, AppTag, …)
    router/       onGenerateRoute
  features/home/presentation/
    pages/        HomePage — section order, navigation, launch handlers
    sections/     Hero and Selected Work
    widgets/      About, Experience, Footer
```

Two conventions worth knowing before editing:

- **Copy belongs in `AppData`.** Widgets read it; they do not hold it. This is
  what keeps a title change from becoming a hunt through the widget tree.
- **Two accents with fixed roles.** `AppColors.lime` marks anything
  interactive — buttons, CTAs, the active state of a control. `AppColors.primary`
  (teal) is structural only: bullets, eyebrows, tags, decorative glows. If it is
  lime, it is clickable.

## Notes on the web build

- **Fonts are bundled**, as static per-weight instances under `assets/fonts`,
  and `GoogleFonts.config.allowRuntimeFetching` is `false`. There is no request
  to `fonts.gstatic.com` on first paint. Adding a weight to the theme means
  adding the matching file, named `<Family>-<Weight>.woff2` — that name is how
  `google_fonts` finds it.
- **`web/index.html` carries a boot splash** removed on Flutter's
  `flutter-first-frame` event, plus a `<noscript>` copy of the content, since a
  canvas-rendered app gives crawlers no text to read.
- **Launches must stay synchronous.** Safari drops the user gesture when the
  tap's task ends and then blocks `window.open` silently, so nothing may be
  awaited between a tap and `launchUrl`. See the comment on `_openCv` in
  `home_page.dart`.
- **`web/_headers`** pins the immutable build output for a year and keeps
  `index.html` uncached.

## Develop

```bash
flutter pub get
flutter run -d chrome
flutter test
flutter analyze
```

## Build

```bash
flutter build web --release
```

## License

Personal portfolio. Not licensed for reuse.
