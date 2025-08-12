import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_button/smart_button.dart';

void main() {
  group('SmartButton Tests', () {
    testWidgets('SmartButton renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmartButton(
              onPressed: () {},
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('SmartButton shows as disabled when onPressed is null', 
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SmartButton(
              onPressed: null,
              child: Text('Disabled Button'),
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('SmartButton accepts custom offline message and title', 
        (WidgetTester tester) async {
      const customMessage = 'Custom offline message';
      const customTitle = 'Custom Title';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmartButton(
              onPressed: () {},
              offlineMessage: customMessage,
              offlineTitle: customTitle,
              child: const Text('Custom Button'),
            ),
          ),
        ),
      );

      expect(find.text('Custom Button'), findsOneWidget);
    });
  });

  group('SmartTextButton Tests', () {
    testWidgets('SmartTextButton renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmartTextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
          ),
        ),
      );

      expect(find.text('Text Button'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });
  });

  group('SmartOutlinedButton Tests', () {
    testWidgets('SmartOutlinedButton renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmartOutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
          ),
        ),
      );

      expect(find.text('Outlined Button'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });

  group('OfflineFeedbackType Tests', () {
    test('OfflineFeedbackType enum has correct values', () {
      expect(OfflineFeedbackType.values.length, 3);
      expect(OfflineFeedbackType.values.contains(OfflineFeedbackType.dialog), true);
      expect(OfflineFeedbackType.values.contains(OfflineFeedbackType.snackbar), true);
      expect(OfflineFeedbackType.values.contains(OfflineFeedbackType.none), true);
    });
  });
}
