import 'package:flutter/material.dart';
import 'connectivity_handler.dart';
import 'offline_feedback_type.dart';
import 'smart_button_theme.dart';

/// Default offline message used when neither the widget nor theme specifies one.
const _kDefaultOfflineMessage =
    'No internet connection available. Please check your connection and try again.';

/// Default offline dialog title used when neither the widget nor theme specifies one.
const _kDefaultOfflineTitle = 'Connection Error';

/// Base class for smart buttons with connectivity checking.
///
/// Provides shared connectivity-aware press/long-press handling for
/// button widgets that use the standard `child` API (ElevatedButton,
/// TextButton, OutlinedButton, FilledButton).
///
/// Parameters set on the widget override [SmartButtonTheme] defaults.
/// When neither the widget nor the theme provides a value, built-in
/// defaults are used.
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
  ///
  /// If null, falls back to [SmartButtonThemeData.feedbackType], then
  /// [OfflineFeedbackType.dialog].
  final OfflineFeedbackType? feedbackType;

  /// The message to display when the button is pressed while offline.
  ///
  /// If null, falls back to [SmartButtonThemeData.offlineMessage], then
  /// a built-in default.
  final String? offlineMessage;

  /// The title to display in the offline dialog.
  ///
  /// If null, falls back to [SmartButtonThemeData.offlineTitle], then
  /// 'Connection Error'.
  final String? offlineTitle;

  /// Callback function that is called when the button is pressed while offline.
  final VoidCallback? onOfflineAction;

  /// Whether to require WiFi or allow any connection.
  ///
  /// If null, falls back to [SmartButtonThemeData.requireWiFi], then false.
  final bool? requireWiFi;

  /// Custom connectivity checker function.
  ///
  /// If null, falls back to [SmartButtonThemeData.connectivityChecker], then
  /// the default connectivity_plus check.
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
    this.feedbackType,
    this.offlineMessage,
    this.offlineTitle,
    this.onOfflineAction,
    this.requireWiFi,
    this.connectivityChecker,
  });

  /// Creates the appropriate Flutter button widget.
  Widget buildButton(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildButton(context);
  }

  /// Resolves [feedbackType] against the theme, falling back to [OfflineFeedbackType.dialog].
  OfflineFeedbackType _resolveFeedbackType(BuildContext context) {
    return feedbackType ??
        SmartButtonTheme.of(context)?.feedbackType ??
        OfflineFeedbackType.dialog;
  }

  /// Resolves [offlineMessage] against the theme.
  String _resolveOfflineMessage(BuildContext context) {
    return offlineMessage ??
        SmartButtonTheme.of(context)?.offlineMessage ??
        _kDefaultOfflineMessage;
  }

  /// Resolves [offlineTitle] against the theme.
  String _resolveOfflineTitle(BuildContext context) {
    return offlineTitle ??
        SmartButtonTheme.of(context)?.offlineTitle ??
        _kDefaultOfflineTitle;
  }

  /// Resolves [requireWiFi] against the theme.
  bool _resolveRequireWiFi(BuildContext context) {
    return requireWiFi ?? SmartButtonTheme.of(context)?.requireWiFi ?? false;
  }

  /// Resolves [connectivityChecker] against the theme.
  Future<bool> Function()? _resolveConnectivityChecker(BuildContext context) {
    return connectivityChecker ??
        SmartButtonTheme.of(context)?.connectivityChecker;
  }

  /// Handles button press events by checking connectivity first.
  ///
  /// If connected, calls [onPressed]. If offline, shows feedback
  /// based on [feedbackType] and calls [onOfflineAction].
  Future<void> handlePress(BuildContext context) async {
    final isConnected = await ConnectivityHandler.checkConnectivity(
      connectivityChecker: _resolveConnectivityChecker(context),
      requireWiFi: _resolveRequireWiFi(context),
    );

    if (isConnected) {
      onPressed?.call();
    } else {
      if (context.mounted) {
        await ConnectivityHandler.handleOfflineFeedback(
          context,
          feedbackType: _resolveFeedbackType(context),
          offlineMessage: _resolveOfflineMessage(context),
          offlineTitle: _resolveOfflineTitle(context),
        );
      }
      onOfflineAction?.call();
    }
  }

  /// Handles button long-press events by checking connectivity first.
  ///
  /// If connected, calls [onLongPress]. If offline, shows feedback
  /// based on [feedbackType] and calls [onOfflineAction].
  Future<void> handleLongPress(BuildContext context) async {
    final isConnected = await ConnectivityHandler.checkConnectivity(
      connectivityChecker: _resolveConnectivityChecker(context),
      requireWiFi: _resolveRequireWiFi(context),
    );

    if (isConnected) {
      onLongPress?.call();
    } else {
      if (context.mounted) {
        await ConnectivityHandler.handleOfflineFeedback(
          context,
          feedbackType: _resolveFeedbackType(context),
          offlineMessage: _resolveOfflineMessage(context),
          offlineTitle: _resolveOfflineTitle(context),
        );
      }
      onOfflineAction?.call();
    }
  }
}
