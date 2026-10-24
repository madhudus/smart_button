import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_feedback_type.dart';
import 'smart_button_theme.dart';

/// Default offline message used when neither the widget nor theme specifies one.
const kDefaultOfflineMessage =
    'No internet connection available. Please check your connection and try again.';

/// Default offline dialog title used when neither the widget nor theme specifies one.
const kDefaultOfflineTitle = 'Connection Error';

/// Shared connectivity checking and offline feedback logic.
///
/// Used by both [BaseSmartButton] and [SmartIconButton] to avoid
/// duplicating connectivity handling code.
class ConnectivityHandler {
  /// Runs [action] if the device is connected, otherwise shows offline
  /// feedback and calls [onOfflineAction].
  ///
  /// Each parameter resolves through a widget → [SmartButtonTheme] → built-in
  /// default fallback chain. The theme is read once, before the connectivity
  /// check, so no inherited lookups happen across the async gap.
  static Future<void> runIfConnected(
    BuildContext context, {
    required VoidCallback? action,
    VoidCallback? onOfflineAction,
    OfflineFeedbackType? feedbackType,
    String? offlineMessage,
    String? offlineTitle,
    bool? requireWiFi,
    Future<bool> Function()? connectivityChecker,
  }) async {
    final theme = SmartButtonTheme.of(context);

    final isConnected = await checkConnectivity(
      connectivityChecker: connectivityChecker ?? theme?.connectivityChecker,
      requireWiFi: requireWiFi ?? theme?.requireWiFi ?? false,
    );

    if (isConnected) {
      action?.call();
      return;
    }

    if (context.mounted) {
      await handleOfflineFeedback(
        context,
        feedbackType:
            feedbackType ?? theme?.feedbackType ?? OfflineFeedbackType.dialog,
        offlineMessage:
            offlineMessage ?? theme?.offlineMessage ?? kDefaultOfflineMessage,
        offlineTitle:
            offlineTitle ?? theme?.offlineTitle ?? kDefaultOfflineTitle,
      );
    }
    onOfflineAction?.call();
  }

  /// Checks whether the device has an acceptable internet connection.
  ///
  /// If [connectivityChecker] is provided, it is used instead of the default
  /// connectivity_plus check. When [requireWiFi] is true, only WiFi connections
  /// are considered acceptable.
  ///
  /// If the check throws, the error is reported and `false` is returned.
  static Future<bool> checkConnectivity({
    Future<bool> Function()? connectivityChecker,
    bool requireWiFi = false,
  }) async {
    try {
      if (connectivityChecker != null) {
        return await connectivityChecker();
      }

      final connectivityResult = await Connectivity().checkConnectivity();

      if (!requireWiFi) {
        return !connectivityResult.contains(ConnectivityResult.none);
      }

      return connectivityResult.contains(ConnectivityResult.wifi);
    } catch (error, stackTrace) {
      return _onCheckFailed(error, stackTrace);
    }
  }

  /// Decides the connectivity result when the check itself throws
  /// (e.g. a custom checker's HTTP ping fails, or the platform plugin is
  /// unavailable).
  ///
  /// The error is reported via [FlutterError.reportError] and the device is
  /// treated as offline, so the user still gets offline feedback and
  /// `onOfflineAction` still runs.
  static bool _onCheckFailed(Object error, StackTrace stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'smart_button',
        context: ErrorDescription('while checking connectivity'),
      ),
    );
    return false;
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
      case OfflineFeedbackType.snackbar:
        _showOfflineSnackbar(context, message: offlineMessage);
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
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
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
    // Replace any visible offline snackbar instead of queueing one per tap.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: MaterialLocalizations.of(context).okButtonLabel,
            // SnackBarAction dismisses its snackbar automatically.
            onPressed: () {},
          ),
        ),
      );
  }
}
