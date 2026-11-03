---
title: "Offline-first Flutter: making the local database the source of truth"
description: "A practical approach to offline-first Flutter apps: every screen reads from local storage, the network only syncs, and the UI never waits on a spinner to show data the user already has."
date: "2026-11-03"
tags: ["Flutter", "Architecture", "Offline-first", "Riverpod"]
draft: true
---

Most apps are "online apps with a cache." Offline-first flips that: the **local database is the source of truth**, and the network is just a way to keep it up to date.

Both myMed and Salati are built this way. Here is the shape of it.

## The one rule

> Screens read from local storage. Only the sync layer talks to the network.

That's it. Everything else follows from this rule.

If a screen ever awaits an HTTP call before showing data, it isn't offline-first.

## The layers

With Clean Architecture boundaries, the flow looks like this:

- **UI** watches a Riverpod provider.
- **The provider** exposes a stream from a repository.
- **The repository** returns a stream straight from the local database.
- **The sync service** pulls from and pushes to the API in the background and writes results into the local database.

Because the UI watches the database, a successful sync updates the screen automatically. The UI never needs to know a network exists.

```dart
final dosesTodayProvider = StreamProvider<List<Dose>>((ref) {
  final repo = ref.watch(doseRepositoryProvider);
  return repo.watchDosesFor(DateTime.now()); // local DB stream
});
```

## Writes go local first

When the user marks a dose as taken, the app:

1. writes it to the local database immediately (the UI updates instantly),
2. records it in an outbox of pending changes,
3. lets the sync service push the outbox when there is a connection.

The user never sees "No connection, try again." The action already happened.

## Conflicts: pick a simple rule and document it

Offline-first means two devices can change the same record. You don't need a CRDT for most apps. Pick a rule that matches the domain:

- **Last write wins** per field, for preferences and settings.
- **Append-only** for logs, like "dose taken" events — they never conflict.

Write the rule down. Future you will forget why it works.

## What you get

- Instant screens, because the data is already on the device.
- Correct behavior on planes, in basements, and on bad networks.
- Simpler UI code — no loading/error branches for data the user already has.

## What it costs

- A real local schema and migrations from day one.
- A sync layer to build and test.
- Thinking about conflicts up front.

For apps people rely on every day, that cost pays for itself quickly.
