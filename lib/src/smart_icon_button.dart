import 'package:flutter/material.dart';
import 'connectivity_handler.dart';
import 'offline_feedback_type.dart';
import 'smart_button_theme.dart';

/// A smart icon button that checks internet connectivity before executing actions.
///
/// This button wraps Flutter's [IconButton] and adds automatic connectivity
/// checking. When pressed while offline, it shows configurable feedback instead
/// of executing the [onPressed] callback.
///
/// Unlike other smart buttons, this does not extend [BaseSmartButton] because
/// [IconButton] has a fundamentally different API (uses [icon] instead of `child`).
///
/// Parameters set on the widget override [SmartButtonTheme] defaults.
///
/// ```dart
/// SmartIconButton(
///   icon: const Icon(Icons.refresh),
///   onPressed: () => fetchData(),
///   feedbackType: OfflineFeedbackType.snackbar,
///   offlineMessage: 'Cannot refresh while offline',
/// )
/// ```
class SmartIconButton extends StatelessWidget {
  /// The icon to display inside the button.
  final Widget icon;

  /// Callback function that is called when the button is pressed and internet is available.
  final VoidCallback? onPressed;

  /// The size of the icon inside the button.
  final double? iconSize;

  /// The visual density of the button.
  final VisualDensity? visualDensity;

  /// The padding around the icon.
  final EdgeInsetsGeometry? padding;

  /// The alignment of the icon within the button.
  final AlignmentGeometry? alignment;

  /// The splash radius of the ink response.
  final double? splashRadius;

  /// The color of the icon.
  final Color? color;

  /// The focus color of the button.
  final Color? focusColor;

  /// The hover color of the button.
  final Color? hoverColor;

  /// The highlight color of the button.
  final Color? highlightColor;

  /// The splash color of the button.
  final Color? splashColor;

  /// The color of the icon when the button is disabled.
  final Color? disabledColor;

  /// The tooltip message for the button.
  final String? tooltip;

  /// Whether to enable haptic feedback.
  final bool? enableFeedback;

  /// Optional size constraints for the button.
  final BoxConstraints? constraints;

  /// The button style (Material 3).
  final ButtonStyle? style;

  /// Whether the icon button is selected.
  final bool? isSelected;

  /// The icon to show when the button is selected.
  final Widget? selectedIcon;

  /// Focus node for managing keyboard focus.
  final FocusNode? focusNode;

  /// Whether the button should automatically request focus.
  final bool autofocus;

  /// The type of feedback to show when the button is pressed while offline.
  ///
  /// If null, falls back to [SmartButtonThemeData.feedbackType], then
  /// [OfflineFeedbackType.dialog].
  final OfflineFeedbackType? feedbackType;

  /// The message to display when the button is pressed while offline.
  ///
  /// If null, falls back to [SmartButtonThemeData.offlineMessage].
  final String? offlineMessage;

  /// The title to display in the offline dialog.
  ///
  /// If null, falls back to [SmartButtonThemeData.offlineTitle].
  final String? offlineTitle;

  /// Callback function that is called when the button is pressed while offline.
  final VoidCallback? onOfflineAction;

  /// Whether to require WiFi connectivity.
  ///
  /// If null, falls back to [SmartButtonThemeData.requireWiFi], then false.
  final bool? requireWiFi;

  /// Custom connectivity checker function.
  ///
  /// If null, falls back to [SmartButtonThemeData.connectivityChecker].
  final Future<bool> Function()? connectivityChecker;

  /// Creates a smart icon button with connectivity checking.
  const SmartIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    this.focusNode,
    this.autofocus = false,
    this.feedbackType,
    this.offlineMessage,
    this.offlineTitle,
    this.onOfflineAction,
    this.requireWiFi,
    this.connectivityChecker,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed != null ? () => _handlePress(context) : null,
      iconSize: iconSize,
      visualDensity: visualDensity,
      padding: padding,
      alignment: alignment,
      splashRadius: splashRadius,
      color: color,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      disabledColor: disabledColor,
      tooltip: tooltip,
      enableFeedback: enableFeedback,
      constraints: constraints,
      style: style,
      isSelected: isSelected,
      selectedIcon: selectedIcon,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }

  Future<void> _handlePress(BuildContext context) {
    return ConnectivityHandler.runIfConnected(
      context,
      action: onPressed,
      onOfflineAction: onOfflineAction,
      feedbackType: feedbackType,
      offlineMessage: offlineMessage,
      offlineTitle: offlineTitle,
      requireWiFi: requireWiFi,
      connectivityChecker: connectivityChecker,
    );
  }
}
