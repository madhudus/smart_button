import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_button/smart_button.dart';

/// Helper that wraps a widget in MaterialApp + Scaffold for testing.
Widget buildTestApp(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

/// Always-online connectivity checker for tests.
Future<bool> alwaysOnline() async => true;

/// Always-offline connectivity checker for tests.
Future<bool> alwaysOffline() async => false;

void main() {
  // ─────────────────────────────────────────────
  // SmartButton (ElevatedButton) Tests
  // ─────────────────────────────────────────────

  group('SmartButton', () {
    testWidgets('renders as ElevatedButton with child', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartButton(
            onPressed: () {},
            connectivityChecker: alwaysOnline,
            child: const Text('Test'),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows as disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          const SmartButton(onPressed: null, child: Text('Disabled')),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('executes onPressed when online', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartButton(
            onPressed: () => pressed = true,
            connectivityChecker: alwaysOnline,
            child: const Text('Online'),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('blocks onPressed when offline', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartButton(
            onPressed: () => pressed = true,
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.none,
            child: const Text('Offline'),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(pressed, isFalse);
    });

    testWidgets('shows dialog when offline + feedbackType.dialog', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartButton(
            onPressed: () {},
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.dialog,
            offlineTitle: 'No Connection',
            offlineMessage: 'You are offline',
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('No Connection'), findsOneWidget);
      expect(find.text('You are offline'), findsOneWidget);

      // Dismiss dialog
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
    });

    testWidgets('shows snackbar when offline + feedbackType.snackbar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartButton(
            onPressed: () {},
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.snackbar,
            offlineMessage: 'Snackbar message',
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Snackbar message'), findsOneWidget);
    });

    testWidgets('shows no feedback when offline + feedbackType.none', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartButton(
            onPressed: () {},
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.none,
            offlineMessage: 'Should not appear',
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Should not appear'), findsNothing);
    });

    testWidgets('calls onOfflineAction when offline', (
      WidgetTester tester,
    ) async {
      bool offlineActionCalled = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartButton(
            onPressed: () {},
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.none,
            onOfflineAction: () => offlineActionCalled = true,
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(offlineActionCalled, isTrue);
    });

    testWidgets('blocks onLongPress when offline', (WidgetTester tester) async {
      bool longPressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartButton(
            onPressed: () {},
            onLongPress: () => longPressed = true,
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.none,
            child: const Text('Long Press'),
          ),
        ),
      );

      await tester.longPress(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(longPressed, isFalse);
    });

    testWidgets('executes onLongPress when online', (
      WidgetTester tester,
    ) async {
      bool longPressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartButton(
            onPressed: () {},
            onLongPress: () => longPressed = true,
            connectivityChecker: alwaysOnline,
            child: const Text('Long Press'),
          ),
        ),
      );

      await tester.longPress(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(longPressed, isTrue);
    });
  });

  // ─────────────────────────────────────────────
  // SmartTextButton Tests
  // ─────────────────────────────────────────────

  group('SmartTextButton', () {
    testWidgets('renders as TextButton with child', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartTextButton(
            onPressed: () {},
            connectivityChecker: alwaysOnline,
            child: const Text('Text'),
          ),
        ),
      );

      expect(find.text('Text'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('executes onPressed when online', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartTextButton(
            onPressed: () => pressed = true,
            connectivityChecker: alwaysOnline,
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('blocks onPressed when offline', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartTextButton(
            onPressed: () => pressed = true,
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.none,
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(pressed, isFalse);
    });
  });

  // ─────────────────────────────────────────────
  // SmartOutlinedButton Tests
  // ─────────────────────────────────────────────

  group('SmartOutlinedButton', () {
    testWidgets('renders as OutlinedButton with child', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartOutlinedButton(
            onPressed: () {},
            connectivityChecker: alwaysOnline,
            child: const Text('Outlined'),
          ),
        ),
      );

      expect(find.text('Outlined'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('blocks onPressed when offline', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartOutlinedButton(
            onPressed: () => pressed = true,
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.none,
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      expect(pressed, isFalse);
    });
  });

  // ─────────────────────────────────────────────
  // SmartFilledButton Tests
  // ─────────────────────────────────────────────

  group('SmartFilledButton', () {
    testWidgets('renders as FilledButton with child', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartFilledButton(
            onPressed: () {},
            connectivityChecker: alwaysOnline,
            child: const Text('Filled'),
          ),
        ),
      );

      expect(find.text('Filled'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('executes onPressed when online', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartFilledButton(
            onPressed: () => pressed = true,
            connectivityChecker: alwaysOnline,
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('blocks onPressed when offline', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartFilledButton(
            onPressed: () => pressed = true,
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.none,
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(pressed, isFalse);
    });

    testWidgets('shows dialog when offline', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartFilledButton(
            onPressed: () {},
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.dialog,
            offlineTitle: 'Offline',
            offlineMessage: 'No connection',
            child: const Text('Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(find.text('Offline'), findsOneWidget);
      expect(find.text('No connection'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
    });
  });

  // ─────────────────────────────────────────────
  // SmartIconButton Tests
  // ─────────────────────────────────────────────

  group('SmartIconButton', () {
    testWidgets('renders with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartIconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
            connectivityChecker: alwaysOnline,
          ),
        ),
      );

      expect(find.byIcon(Icons.refresh), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('executes onPressed when online', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartIconButton(
            icon: const Icon(Icons.send),
            onPressed: () => pressed = true,
            connectivityChecker: alwaysOnline,
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('blocks onPressed when offline', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartIconButton(
            icon: const Icon(Icons.send),
            onPressed: () => pressed = true,
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.none,
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(pressed, isFalse);
    });

    testWidgets('shows snackbar when offline', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartIconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.snackbar,
            offlineMessage: 'Icon offline',
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text('Icon offline'), findsOneWidget);
    });

    testWidgets('displays tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestApp(
          SmartIconButton(
            icon: const Icon(Icons.info),
            onPressed: () {},
            tooltip: 'Info button',
            connectivityChecker: alwaysOnline,
          ),
        ),
      );

      expect(find.byTooltip('Info button'), findsOneWidget);
    });

    testWidgets('calls onOfflineAction when offline', (
      WidgetTester tester,
    ) async {
      bool offlineActionCalled = false;

      await tester.pumpWidget(
        buildTestApp(
          SmartIconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
            connectivityChecker: alwaysOffline,
            feedbackType: OfflineFeedbackType.none,
            onOfflineAction: () => offlineActionCalled = true,
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(offlineActionCalled, isTrue);
    });

    testWidgets('shows as disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestApp(
          const SmartIconButton(icon: Icon(Icons.send), onPressed: null),
        ),
      );

      final button = tester.widget<IconButton>(find.byType(IconButton));
      expect(button.onPressed, isNull);
    });
  });

  // ─────────────────────────────────────────────
  // SmartButtonTheme Tests
  // ─────────────────────────────────────────────

  group('SmartButtonTheme', () {
    testWidgets('theme defaults are applied when no explicit params', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: SmartButtonTheme(
            data: SmartButtonThemeData(
              feedbackType: OfflineFeedbackType.snackbar,
              offlineMessage: 'Theme message',
              connectivityChecker: alwaysOffline,
            ),
            child: Scaffold(
              body: SmartButton(
                onPressed: () => pressed = true,
                child: const Text('Themed'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Should be blocked (offline from theme checker)
      expect(pressed, isFalse);
      // Should show snackbar with theme message
      expect(find.text('Theme message'), findsOneWidget);
    });

    testWidgets('explicit params override theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SmartButtonTheme(
            data: SmartButtonThemeData(
              feedbackType: OfflineFeedbackType.snackbar,
              offlineMessage: 'Theme message',
              connectivityChecker: alwaysOffline,
            ),
            child: Scaffold(
              body: SmartButton(
                onPressed: () {},
                connectivityChecker: alwaysOffline,
                feedbackType: OfflineFeedbackType.dialog,
                offlineTitle: 'Widget Title',
                offlineMessage: 'Widget message',
                child: const Text('Override'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Should show dialog (widget override), not snackbar (theme)
      expect(find.text('Widget Title'), findsOneWidget);
      expect(find.text('Widget message'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
    });

    testWidgets('nested themes: inner theme overrides outer', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SmartButtonTheme(
            data: SmartButtonThemeData(
              offlineMessage: 'Outer message',
              connectivityChecker: alwaysOffline,
              feedbackType: OfflineFeedbackType.snackbar,
            ),
            child: SmartButtonTheme(
              data: SmartButtonThemeData(
                offlineMessage: 'Inner message',
                connectivityChecker: alwaysOffline,
                feedbackType: OfflineFeedbackType.snackbar,
              ),
              child: Scaffold(
                body: SmartButton(
                  onPressed: () {},
                  child: const Text('Nested'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Inner message'), findsOneWidget);
      expect(find.text('Outer message'), findsNothing);
    });

    testWidgets('theme applies to SmartIconButton', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: SmartButtonTheme(
            data: SmartButtonThemeData(
              connectivityChecker: alwaysOffline,
              feedbackType: OfflineFeedbackType.none,
            ),
            child: Scaffold(
              body: SmartIconButton(
                icon: const Icon(Icons.send),
                onPressed: () => pressed = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(pressed, isFalse);
    });

    testWidgets('theme applies to SmartFilledButton', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: SmartButtonTheme(
            data: SmartButtonThemeData(
              connectivityChecker: alwaysOffline,
              feedbackType: OfflineFeedbackType.none,
            ),
            child: Scaffold(
              body: SmartFilledButton(
                onPressed: () => pressed = true,
                child: const Text('Themed Filled'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      expect(pressed, isFalse);
    });

    testWidgets('of() returns null when no theme ancestor', (
      WidgetTester tester,
    ) async {
      SmartButtonThemeData? capturedTheme;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                capturedTheme = SmartButtonTheme.of(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(capturedTheme, isNull);
    });
  });

  // ─────────────────────────────────────────────
  // OfflineFeedbackType Tests
  // ─────────────────────────────────────────────

  group('OfflineFeedbackType', () {
    test('enum has correct values', () {
      expect(OfflineFeedbackType.values.length, 3);
      expect(
        OfflineFeedbackType.values.contains(OfflineFeedbackType.dialog),
        true,
      );
      expect(
        OfflineFeedbackType.values.contains(OfflineFeedbackType.snackbar),
        true,
      );
      expect(
        OfflineFeedbackType.values.contains(OfflineFeedbackType.none),
        true,
      );
    });
  });

  // ─────────────────────────────────────────────
  // SmartButtonThemeData Tests
  // ─────────────────────────────────────────────

  group('SmartButtonThemeData', () {
    test('copyWith replaces fields', () {
      const original = SmartButtonThemeData(
        feedbackType: OfflineFeedbackType.dialog,
        offlineMessage: 'Original',
      );

      final copied = original.copyWith(
        feedbackType: OfflineFeedbackType.snackbar,
      );

      expect(copied.feedbackType, OfflineFeedbackType.snackbar);
      expect(copied.offlineMessage, 'Original'); // preserved
    });

    test('copyWith preserves unchanged fields', () {
      const original = SmartButtonThemeData(
        feedbackType: OfflineFeedbackType.dialog,
        offlineMessage: 'Msg',
        offlineTitle: 'Title',
        requireWiFi: true,
      );

      final copied = original.copyWith(offlineMessage: 'New');

      expect(copied.feedbackType, OfflineFeedbackType.dialog);
      expect(copied.offlineMessage, 'New');
      expect(copied.offlineTitle, 'Title');
      expect(copied.requireWiFi, true);
    });
  });
}
