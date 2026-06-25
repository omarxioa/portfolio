// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/app.dart';

void main() {
  testWidgets('Portfolio home renders core sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text("Hi, I'm Omar Abdelnaby"), findsOneWidget);
    expect(find.text('About Me'), findsOneWidget);
    expect(find.text('Experience'), findsOneWidget);
    expect(find.text('Featured Projects'), findsOneWidget);
  });
}
