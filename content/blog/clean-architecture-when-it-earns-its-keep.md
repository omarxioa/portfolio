---
title: "Clean Architecture in Flutter: use it when it earns speed, not because it's fashionable"
description: "How I decide how much architecture a Flutter app needs, the layer boundaries I actually enforce with Riverpod, and the places where I deliberately skip ceremony."
date: "2026-11-02"
tags: ["Flutter", "Clean Architecture", "Riverpod", "Team"]
draft: true
---

"Clean Architecture" in Flutter often turns into a folder structure with five files for every button. That's not the goal.

I use architecture when it earns three things: **speed, reliability, and easier team scaling.** If a layer doesn't help with one of those, it doesn't go in.

## The boundaries I actually enforce

On every project at SOAcode, the rules the team builds against are short:

- **Presentation** knows about Riverpod and widgets. It never imports an HTTP client or a database.
- **Domain** is plain Dart: entities and use cases where they carry real logic. No Flutter imports.
- **Data** implements repositories and owns every external dependency — APIs, local DB, platform channels.

Dependencies point inward. The UI can be rewritten without touching the domain, and the API can change without touching the UI.

## Where I skip ceremony

- **No use case that just forwards a call.** If `GetUserUseCase` only calls `repository.getUser()`, delete it and call the repository.
- **No mapper for identical shapes.** Map DTOs to entities when they differ, not as a ritual.
- **Small features stay small.** A settings screen doesn't need the same structure as a sync engine.

## Riverpod makes the boundaries cheap

Providers are the wiring. Repositories are provided as interfaces, so tests override them in one line:

```dart
final container = ProviderContainer(overrides: [
  doseRepositoryProvider.overrideWithValue(FakeDoseRepository()),
]);
```

No service locator, no global state, and every dependency is visible.

## Why this matters for a team

Architecture is mostly about people. Clear boundaries mean:

- a new developer knows where code goes on day one,
- pull requests are easy to review because changes stay in one layer,
- two people can work on the same feature without conflicts.

Every pull request is reviewed against these rules. That review, more than any folder structure, is what keeps a codebase healthy.

## The takeaway

Don't ask "is this Clean Architecture?" Ask "does this layer make us faster, more reliable, or easier to grow?" Keep what passes. Delete the rest.
