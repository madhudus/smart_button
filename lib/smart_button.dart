export 'src/smart_button_widget.dart';
export 'src/offline_feedback_type.dart';
export 'src/base_smart_button.dart';

/// SmartButton widgets with built-in connectivity checking.
///
/// This library provides three button widgets that automatically check for
/// internet connectivity before executing their onPressed callbacks:
///
/// - [SmartButton]: Enhanced ElevatedButton with connectivity awareness
/// - [SmartTextButton]: Enhanced TextButton with connectivity awareness
/// - [SmartOutlinedButton]: Enhanced OutlinedButton with connectivity awareness
///
/// All buttons support configurable offline feedback via [OfflineFeedbackType]:
/// - [OfflineFeedbackType.dialog]: Shows adaptive alert dialog
/// - [OfflineFeedbackType.snackbar]: Shows snackbar notification
/// - [OfflineFeedbackType.none]: No visual feedback
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
///
/// Advanced usage with connectivity options:
/// ```dart
/// SmartButton(
///   onPressed: () {
///     print('Connected action executed');
///   },
///   requireWiFi: true, // Only allow WiFi connections
///   feedbackType: OfflineFeedbackType.snackbar,
///   offlineMessage: 'Please connect to WiFi',
///   child: Text('WiFi Only Button'),
/// )
/// ```
