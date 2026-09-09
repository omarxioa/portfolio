import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app.dart';

/// Realistic viewports the site has to survive, in logical pixels.
///
/// Kept as a single list so every responsive test covers the same matrix.
const List<({String name, Size size})> kViewports = [
  (name: 'phone-320 (iPhone SE 1st gen)', size: Size(320, 568)),
  (name: 'phone-360 (Android baseline)', size: Size(360, 800)),
  (name: 'phone-390 (iPhone 14)', size: Size(390, 844)),
  (name: 'phone-430 (iPhone Pro Max)', size: Size(430, 932)),
  (name: 'tablet-600 (small tablet)', size: Size(600, 960)),
  (name: 'tablet-768 (iPad portrait)', size: Size(768, 1024)),
  (name: 'tablet-834 (iPad Air portrait)', size: Size(834, 1194)),
  (name: 'tablet-1024 (iPad landscape)', size: Size(1024, 768)),
  (name: 'desktop-1280', size: Size(1280, 800)),
  (name: 'desktop-1440', size: Size(1440, 900)),
  (name: 'desktop-1920', size: Size(1920, 1080)),
  (name: 'desktop-2560 (ultrawide)', size: Size(2560, 1440)),
];

/// Pumps the real app at [size] and runs past the terminal intro overlay.
///
/// Returns every distinct framework error raised while rendering, so callers
/// can assert on layout overflows that Flutter reports but does not throw.
Future<List<String>> pumpPortfolio(
  WidgetTester tester, {
  Size size = const Size(1440, 900),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final errors = <String>[];
  final previousOnError = FlutterError.onError;
  FlutterError.onError = (details) {
    errors.add(details.exceptionAsString().split('\n').first);
  };
  try {
    await tester.pumpWidget(const ProviderScope(child: PortfolioApp()));
    await settle(tester);
  } finally {
    // Must be restored before the caller runs any expect(): flutter_test
    // asserts that a test hands FlutterError.onError back before matching.
    FlutterError.onError = previousOnError;
  }

  return errors;
}

/// Asset names of every rendered [Image], unwrapping the [ResizeImage] that
/// `Image.asset(cacheWidth: ...)` puts around the underlying [AssetImage].
List<String> renderedAssetNames(WidgetTester tester) {
  return tester
      .widgetList<Image>(find.byType(Image))
      .map((image) {
        final provider = image.image;
        final unwrapped = provider is ResizeImage
            ? provider.imageProvider
            : provider;
        return unwrapped is AssetImage ? unwrapped.assetName : null;
      })
      .whereType<String>()
      .toList();
}

/// Advances time in slices. The hero and case-study sections run looping
/// animations, so [WidgetTester.pumpAndSettle] would never return.
Future<void> settle(
  WidgetTester tester, {
  Duration total = const Duration(seconds: 18),
}) async {
  const step = Duration(milliseconds: 300);
  for (var elapsed = Duration.zero; elapsed < total; elapsed += step) {
    await tester.pump(step);
  }
}
