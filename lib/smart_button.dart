/// SmartButton widgets with built-in connectivity checking.
///
/// This library provides five button widgets that automatically check for
/// internet connectivity before executing their onPressed callbacks:
///
/// - [SmartButton]: Enhanced ElevatedButton with connectivity awareness
/// - [SmartTextButton]: Enhanced TextButton with connectivity awareness
/// - [SmartOutlinedButton]: Enhanced OutlinedButton with connectivity awareness
/// - [SmartFilledButton]: Enhanced FilledButton (Material 3) with connectivity awareness
/// - [SmartIconButton]: Enhanced IconButton with connectivity awareness
///
/// All buttons support configurable offline feedback via [OfflineFeedbackType]:
/// - [OfflineFeedbackType.dialog]: Shows adaptive alert dialog
/// - [OfflineFeedbackType.snackbar]: Shows snackbar notification
/// - [OfflineFeedbackType.none]: No visual feedback
///
/// Use [SmartButtonTheme] to set global defaults for all smart buttons:
/// ```dart
/// SmartButtonTheme(
///   data: SmartButtonThemeData(
///     feedbackType: OfflineFeedbackType.snackbar,
///     offlineMessage: 'You are offline',
///   ),
///   child: MyApp(),
/// )
/// ```
///
/// Example usage:
/// ```dart
/// SmartButton(
///   onPressed: () {
///     // This will only execute if internet is available
///     print('Connected action executed');
///   },
///   feedbackType: OfflineFeedbackType.snackbar,
///   offlineMessage: 'Please check your internet connection',
///   child: Text('Smart Button'),
/// )
/// ```
library;

export 'src/smart_button_widget.dart';
export 'src/offline_feedback_type.dart';
export 'src/base_smart_button.dart';
export 'src/connectivity_handler.dart';
export 'src/smart_icon_button.dart';
export 'src/smart_button_theme.dart';
