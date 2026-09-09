import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/pump_app.dart';

void main() {
  testWidgets('renders the hero, work, experience and contact sections', (
    tester,
  ) async {
    final errors = await pumpPortfolio(tester);

    expect(find.text("Hi, I'm Omar."), findsOneWidget);
    expect(find.text('Featured Personal Projects'), findsOneWidget);
    expect(find.text('myMed'), findsOneWidget);
    expect(find.text('Salati'), findsOneWidget);
    expect(find.text('Experience'), findsWidgets);
    expect(find.text('Contact'), findsWidgets);

    expect(errors, isEmpty);
  });

  testWidgets('case study screenshots resolve to bundled assets', (
    tester,
  ) async {
    await pumpPortfolio(tester);

    final assetNames = renderedAssetNames(tester);

    expect(assetNames, isNotEmpty);
    expect(assetNames.every((name) => name.endsWith('.webp')), isTrue);
    expect(find.text('Screenshot unavailable'), findsNothing);
  });

  testWidgets('switching a case study tab swaps the screenshot', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    // Tall viewport so the case study controls are on screen and genuinely
    // hit-testable rather than scrolled out of the view.
    final errors = await pumpPortfolio(tester, size: const Size(1440, 2600));

    String currentMyMedAsset() => renderedAssetNames(
      tester,
    ).firstWhere((name) => !name.contains('salati'));

    final before = currentMyMedAsset();
    await tester.tap(find.bySemanticsLabel('Open Progress screen preview'));
    await settle(tester, total: const Duration(seconds: 3));

    expect(currentMyMedAsset(), isNot(before));
    expect(errors, isEmpty);
    handle.dispose();
  });

  testWidgets('light mode toggle swaps to the light screenshot', (
    tester,
  ) async {
    final errors = await pumpPortfolio(tester, size: const Size(1440, 2600));

    // The toggle's Semantics label wraps a Text, so target the label itself.
    await tester.tap(find.text('Light').first);
    await settle(tester, total: const Duration(seconds: 3));

    final assetNames = renderedAssetNames(tester);

    expect(assetNames.any((name) => name.contains('_light')), isTrue);
    expect(errors, isEmpty);
  });

  testWidgets('back-to-top button appears only after scrolling', (
    tester,
  ) async {
    final errors = await pumpPortfolio(tester);

    expect(find.byType(FloatingActionButton), findsNothing);

    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -1500),
    );
    await settle(tester, total: const Duration(seconds: 3));

    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(errors, isEmpty);
  });

  testWidgets('mobile nav opens the jump-to-section sheet', (tester) async {
    final errors = await pumpPortfolio(tester, size: const Size(390, 844));

    await tester.tap(find.text('Menu'));
    await settle(tester, total: const Duration(seconds: 3));

    expect(find.text('Jump to section'), findsOneWidget);
    expect(find.text('Download Resume'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Work'), findsOneWidget);
    expect(errors, isEmpty);
  });
}
