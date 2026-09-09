import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/pump_app.dart';

void main() {
  group('lays out without overflow', () {
    for (final viewport in kViewports) {
      testWidgets('at ${viewport.name}', (tester) async {
        final errors = await pumpPortfolio(tester, size: viewport.size);

        expect(
          errors,
          isEmpty,
          reason:
              'Rendering at ${viewport.size.width.toInt()}x'
              '${viewport.size.height.toInt()} reported: ${errors.join(", ")}',
        );

        // The page must never scroll sideways.
        final scrollables = tester.widgetList<SingleChildScrollView>(
          find.byType(SingleChildScrollView),
        );
        expect(scrollables, isNotEmpty);
      });
    }
  });

  group('core content is reachable', () {
    for (final viewport in kViewports) {
      testWidgets('at ${viewport.name}', (tester) async {
        await pumpPortfolio(tester, size: viewport.size);

        expect(find.text("Hi, I'm Omar."), findsOneWidget);
        expect(find.text('myMed'), findsOneWidget);
        expect(find.text('Salati'), findsOneWidget);
        expect(find.text('Discuss This Project'), findsNWidgets(2));
        expect(find.text('View GitHub'), findsNWidgets(2));
      });
    }
  });

  group('navigation adapts', () {
    testWidgets('compact viewports show the menu button', (tester) async {
      await pumpPortfolio(tester, size: const Size(390, 844));

      expect(find.text('Menu'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Work'), findsNothing);
    });

    testWidgets('wide viewports show inline nav links', (tester) async {
      await pumpPortfolio(tester, size: const Size(1440, 900));

      expect(find.text('Menu'), findsNothing);
      expect(find.widgetWithText(TextButton, 'Work'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Experience'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Contact'), findsOneWidget);
    });
  });
}
