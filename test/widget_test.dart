// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hiredstep/ui/application_list/application_list_screen.dart';

void main() {
  testWidgets('shows empty state when there are no application', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: ApplicationListScreen(applications: [])),
    );
    expect(find.text('No applications yet.'), findsOneWidget);
  });
}
