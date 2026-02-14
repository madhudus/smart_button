import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_feedback_type.dart';

/// Shared connectivity checking and offline feedback logic.
///
/// Used by both [BaseSmartButton] and [SmartIconButton] to avoid
/// duplicating connectivity handling code.
class ConnectivityHandler {
  /// Checks whether the device has an acceptable internet connection.
  ///
  /// If [connectivityChecker] is provided, it is used instead of the default
  /// connectivity_plus check. When [requireWiFi] is true, only WiFi connections
  /// are considered acceptable.
  static Future<bool> checkConnectivity({
    Future<bool> Function()? connectivityChecker,
    bool requireWiFi = false,
  }) async {
    if (connectivityChecker != null) {
      return connectivityChecker();
    }

    final connectivityResult = await Connectivity().checkConnectivity();

    if (!requireWiFi) {
      return !connectivityResult.contains(ConnectivityResult.none);
    }

    return connectivityResult.contains(ConnectivityResult.wifi);
  }

  /// Shows offline feedback based on [feedbackType].
  ///
  /// For [OfflineFeedbackType.dialog], shows an adaptive alert dialog.
  /// For [OfflineFeedbackType.snackbar], shows a floating snackbar.
  /// For [OfflineFeedbackType.none], does nothing.
  static Future<void> handleOfflineFeedback(
    BuildContext context, {
    required OfflineFeedbackType feedbackType,
    required String offlineMessage,
    required String offlineTitle,
  }) async {
    switch (feedbackType) {
      case OfflineFeedbackType.dialog:
        await _showOfflineDialog(
          context,
          title: offlineTitle,
          message: offlineMessage,
        );
        break;
      case OfflineFeedbackType.snackbar:
        _showOfflineSnackbar(context, message: offlineMessage);
        break;
      case OfflineFeedbackType.none:
        break;
    }
  }

  static Future<void> _showOfflineDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void _showOfflineSnackbar(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
