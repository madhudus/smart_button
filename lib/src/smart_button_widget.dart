import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_feedback_type.dart';

/// A smart elevated button that checks internet connectivity before executing actions.
///
/// This button wraps Flutter's [ElevatedButton] and adds automatic connectivity
/// checking. When pressed while offline, it shows configurable feedback instead
/// of executing the [onPressed] callback.
class SmartButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStatesController? statesController;
  final Widget child;

  final OfflineFeedbackType feedbackType;
  final String offlineMessage;
  final String offlineTitle;
  final VoidCallback? onOfflineAction;

  /// Creates a smart elevated button.
  ///
  /// The [onPressed] callback is only executed when internet connectivity is available.
  /// When offline, shows feedback based on [feedbackType] and calls [onOfflineAction] if provided.
  const SmartButton({
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
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed != null ? () => _handlePress(context) : null,
      onLongPress: onLongPress != null ? () => _handleLongPress(context) : null,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      child: child,
    );
  }

  Future<void> _handlePress(BuildContext context) async {
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

  Future<void> _handleLongPress(BuildContext context) async {
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
    final connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
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

/// A smart text button that checks internet connectivity before executing actions.
///
/// This button wraps Flutter's [TextButton] and adds automatic connectivity
/// checking. When pressed while offline, it shows configurable feedback instead
/// of executing the [onPressed] callback.
class SmartTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStatesController? statesController;
  final Widget child;

  final OfflineFeedbackType feedbackType;
  final String offlineMessage;
  final String offlineTitle;
  final VoidCallback? onOfflineAction;

  /// Creates a smart text button.
  ///
  /// The [onPressed] callback is only executed when internet connectivity is available.
  /// When offline, shows feedback based on [feedbackType] and calls [onOfflineAction] if provided.
  const SmartTextButton({
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
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed != null ? () => _handlePress(context) : null,
      onLongPress: onLongPress != null ? () => _handleLongPress(context) : null,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      child: child,
    );
  }

  Future<void> _handlePress(BuildContext context) async {
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

  Future<void> _handleLongPress(BuildContext context) async {
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
    final connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
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

/// A smart outlined button that checks internet connectivity before executing actions.
///
/// This button wraps Flutter's [OutlinedButton] and adds automatic connectivity
/// checking. When pressed while offline, it shows configurable feedback instead
/// of executing the [onPressed] callback.
class SmartOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStatesController? statesController;
  final Widget child;

  final OfflineFeedbackType feedbackType;
  final String offlineMessage;
  final String offlineTitle;
  final VoidCallback? onOfflineAction;

  /// Creates a smart outlined button.
  ///
  /// The [onPressed] callback is only executed when internet connectivity is available.
  /// When offline, shows feedback based on [feedbackType] and calls [onOfflineAction] if provided.
  const SmartOutlinedButton({
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
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed != null ? () => _handlePress(context) : null,
      onLongPress: onLongPress != null ? () => _handleLongPress(context) : null,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      child: child,
    );
  }

  Future<void> _handlePress(BuildContext context) async {
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

  Future<void> _handleLongPress(BuildContext context) async {
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
    final connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
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
