import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_feedback_type.dart';

/// Base class for smart buttons with connectivity checking
abstract class BaseSmartButton extends StatelessWidget {
  /// Callback function that is called when the button is pressed and internet is available.
  final VoidCallback? onPressed;

  /// Callback function that is called when the button is long-pressed and internet is available.
  final VoidCallback? onLongPress;

  /// Callback function that is called when the button's hover state changes.
  final ValueChanged<bool>? onHover;

  /// Callback function that is called when the button's focus state changes.
  final ValueChanged<bool>? onFocusChange;

  /// Customizes the button's appearance and behavior.
  final ButtonStyle? style;

  /// Focus node for managing keyboard focus on this button.
  final FocusNode? focusNode;

  /// Whether the button should automatically request focus when it becomes visible.
  final bool autofocus;

  /// The content clipping behavior for this button.
  final Clip clipBehavior;

  /// Controller for tracking and modifying the button's states.
  final WidgetStatesController? statesController;

  /// The widget to display inside the button.
  final Widget child;

  /// The type of feedback to show when the button is pressed while offline.
  final OfflineFeedbackType feedbackType;

  /// The message to display when the button is pressed while offline.
  final String offlineMessage;

  /// The title to display in the offline dialog.
  final String offlineTitle;

  /// Callback function that is called when the button is pressed while offline.
  final VoidCallback? onOfflineAction;

  /// Whether to require any connection or allow mobile data
  final bool requireWiFi;

  /// Custom connectivity checker function
  final Future<bool> Function()? connectivityChecker;

  /// Creates a base smart button with connectivity checking.
  ///
  /// The [onPressed] and [child] parameters are required.
  /// All other parameters are optional and provide customization options.
  const BaseSmartButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    required this.child,
    this.feedbackType = OfflineFeedbackType.dialog,
    this.offlineMessage =
        'No internet connection available. Please check your connection and try again.',
    this.offlineTitle = 'Connection Error',
    this.onOfflineAction,
    this.requireWiFi = false,
    this.connectivityChecker,
  });

  // Public getters for testing
  Future<bool> Function()? get connectivityCheckerGetter => connectivityChecker;

  /// Creates the appropriate Flutter button widget
  Widget buildButton(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildButton(context);
  }

  /// Handles button press events by checking connectivity first.
  ///
  /// If connected, calls [onPressed]. If offline, shows feedback
  /// based on [feedbackType] and calls [onOfflineAction].
  Future<void> handlePress(BuildContext context) async {
    final isConnected = await _checkConnectivity();

    if (isConnected) {
      onPressed?.call();
    } else {
      if (context.mounted) {
        await _handleOfflineAction(context);
      }
      onOfflineAction?.call();
    }
  }

  /// Handles button long-press events by checking connectivity first.
  ///
  /// If connected, calls [onLongPress]. If offline, shows feedback
  /// based on [feedbackType] and calls [onOfflineAction].
  Future<void> handleLongPress(BuildContext context) async {
    final isConnected = await _checkConnectivity();

    if (isConnected) {
      onLongPress?.call();
    } else {
      if (context.mounted) {
        await _handleOfflineAction(context);
      }
      onOfflineAction?.call();
    }
  }

  Future<bool> _checkConnectivity() async {
    // Use custom checker if provided
    if (connectivityChecker != null) {
      return connectivityChecker!();
    }

    // Default connectivity checking
    final connectivityResult = await Connectivity().checkConnectivity();

    // If we don't require WiFi, any connection is fine
    if (!requireWiFi) {
      return !connectivityResult.contains(ConnectivityResult.none);
    }

    // If we require WiFi, only WiFi is acceptable
    return connectivityResult.contains(ConnectivityResult.wifi);
  }

  Future<void> _handleOfflineAction(BuildContext context) async {
    switch (feedbackType) {
      case OfflineFeedbackType.dialog:
        await _showOfflineDialog(context);
        break;
      case OfflineFeedbackType.snackbar:
        _showOfflineSnackbar(context);
        break;
      case OfflineFeedbackType.none:
        break;
    }
  }

  Future<void> _showOfflineDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(offlineTitle),
          content: Text(offlineMessage),
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

  void _showOfflineSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(offlineMessage),
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
