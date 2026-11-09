---
title: "Reminders that survive a reboot: scheduling notifications in Flutter that actually fire"
description: "Why medication and prayer reminders fail in the background on Android and iOS, and the scheduling approach I use so they still fire after the app is killed, after Doze, and after a reboot."
date: "2026-11-04"
tags: ["Flutter", "Notifications", "Android", "iOS"]
draft: true
---

A reminder app has one job. If the reminder doesn't fire, nothing else in the app matters — not the design, not the animations, not the architecture.

While building **myMed** (medication reminders) and **Salati** (prayer times), I learned that "schedule a notification" is the easy 10%. The hard 90% is everything the operating system does to stop your app from running when the user isn't looking at it.

This post is the checklist I wish I had at the start.

## The failure cases nobody demos

In a simulator, every notification fires on time. On real phones, reminders silently disappear when:

- **The user swipes the app away.** Some Android vendors treat this as "kill everything this app ever scheduled."
- **The phone enters Doze.** Inexact alarms get batched and delayed — sometimes by a long time.
- **The phone reboots.** Android clears scheduled alarms on reboot. If you don't reschedule, they are gone.
- **The timezone or clock changes.** Travel, daylight saving, or a manual clock change shifts every scheduled time.
- **The app depends on the network** to know *what* to schedule.

Each of these needs its own answer.

## Rule 1: schedule from local data, never from the network

The schedule must be computable entirely on the device. In myMed, doses live in a local database; in Salati, prayer times are calculated locally from coordinates and a calculation method. The network is only ever used to *sync*, never to *decide*.

If computing tomorrow's reminders requires an API call, you have already lost on a plane, in a basement, or on a cheap data plan.

## Rule 2: schedule ahead, in a rolling window

Don't schedule one notification and hope the app wakes up to schedule the next. Schedule a rolling window ahead (for example, the next several days) and top it up whenever the app opens or a background task runs.

```dart
Future<void> rescheduleWindow() async {
  await notifications.cancelAll();
  final upcoming = await repository.remindersBetween(
    DateTime.now(),
    DateTime.now().add(const Duration(days: 7)),
  );
  for (final r in upcoming) {
    await notifications.zonedSchedule(
      r.id,
      r.title,
      r.body,
      tz.TZDateTime.from(r.time, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
```

Keep the platform limits in mind — iOS caps pending local notifications per app, so the window must fit under it.

## Rule 3: exact alarms are a permission, not a default

On recent Android versions, exact alarms need the user's permission. If you fall back to inexact scheduling silently, Doze will happily deliver your 5:00 reminder at 5:20. For a prayer or a medication, that is a bug.

Check the permission, explain *why* you need it in plain language, and route the user to the settings screen if it is denied.

## Rule 4: reschedule on boot and on time changes

Register for the boot-completed and time/timezone-changed broadcasts on Android and call the same `rescheduleWindow()` from there. One function, one source of truth, called from every entry point:

- app start
- boot completed
- timezone or time changed
- after the user edits a reminder

## Rule 5: test the ugly paths on real devices

My test matrix for every release:

1. Schedule, swipe the app away, wait.
2. Schedule, reboot, wait.
3. Schedule, change timezone, check times.
4. Schedule, leave the phone idle on a desk long enough for Doze.
5. Repeat on at least one aggressive-battery vendor device.

If a reminder app hasn't passed this list, it isn't done.

## The takeaway

Reliability is not a feature you add at the end. It is a set of decisions — local-first data, rolling windows, exact alarms, reschedule hooks — that shape the architecture from the first commit.
