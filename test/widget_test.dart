// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gardenia/gardenia.dart';

void main() {
  // test('calculates area of rectangle correctly', () {
  //   // Arrange
  //   final newScreen = 1;
  //
  //   final currentScreen = changeScreen(newScreen);
  //
  //   expect(currentScreen, equals(1));  // Expected area is 6.0
  // });

  // testWidgets(
  //   'test widget',
  //       (widgetTester)async
  //   {
  //     // await widgetTester.pumpWidget(const MyApp());
  //     final tff = find.byType(TFF);
  //     expect(tff, findsOneWidget);
  //   },
  // );

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Gardenia());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
