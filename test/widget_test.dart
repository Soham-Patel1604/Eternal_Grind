// Basic widget test for Eternal Grind
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eternal_grind/main.dart';

void main() {
  testWidgets('App initializes without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());
    
    // Wait for initialization
    await tester.pumpAndSettle();
    
    // Verify app loads
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
