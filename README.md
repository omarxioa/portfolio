# Omar Abdelnaby Portfolio

Personal Flutter portfolio website showcasing product-focused mobile case studies,
engineering experience, and contact channels.

## Highlights

- Interactive case study previews with screen switching and light/dark device mode.
- Project storytelling blocks: Problem, Solution, Impact, and contribution details.
- Direct contact actions via WhatsApp, LinkedIn, and GitHub.
- Responsive layout optimized for mobile, tablet, and desktop.

## Tech Stack

- Flutter
- Dart
- Riverpod
- url_launcher

## Project Structure

- lib/core: Design tokens, shared constants, layout primitives.
- lib/features/home: Hero, selected work, experience, and contact sections.
- assets/images: App screenshots and visual assets.
- web: SEO metadata, PWA config, and static web files.

## Run Locally

```bash
flutter pub get
flutter run -d chrome
```

## Build For Web

```bash
flutter build web
```

## Personalization Checklist

Update these values before publishing:

- Contact and profile links in lib/core/constants/app_data.dart.
- CV file path and asset content in assets/cv.
- Project screenshots in assets/images.
- Domain and social preview metadata in web/index.html.

## License

This repository is for personal portfolio use.
