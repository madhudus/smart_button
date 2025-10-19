import 'package:flutter/material.dart';
import 'base_smart_button.dart';

/// A smart elevated button that checks internet connectivity before executing actions.
///
/// This button wraps Flutter's [ElevatedButton] and adds automatic connectivity
/// checking. When pressed while offline, it shows configurable feedback instead
/// of executing the [onPressed] callback.
class SmartButton extends BaseSmartButton {
  /// Creates a smart elevated button.
  ///
  /// The [onPressed] callback is only executed when internet connectivity is available.
  /// When offline, shows feedback based on [feedbackType] and calls [onOfflineAction] if provided.
  const SmartButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    required super.child,
    super.feedbackType,
    super.offlineMessage,
    super.offlineTitle,
    super.onOfflineAction,
    super.requireWiFi,
    super.connectivityChecker,
  });

  @override
  Widget buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed != null ? () => handlePress(context) : null,
      onLongPress: onLongPress != null ? () => handleLongPress(context) : null,
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
}

/// A smart text button that checks internet connectivity before executing actions.
///
/// This button wraps Flutter's [TextButton] and adds automatic connectivity
/// checking. When pressed while offline, it shows configurable feedback instead
/// of executing the [onPressed] callback.
class SmartTextButton extends BaseSmartButton {
  /// Creates a smart text button.
  ///
  /// The [onPressed] callback is only executed when internet connectivity is available.
  /// When offline, shows feedback based on [feedbackType] and calls [onOfflineAction] if provided.
  const SmartTextButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    required super.child,
    super.feedbackType,
    super.offlineMessage,
    super.offlineTitle,
    super.onOfflineAction,
    super.requireWiFi,
    super.connectivityChecker,
  });

  @override
  Widget buildButton(BuildContext context) {
    return TextButton(
      onPressed: onPressed != null ? () => handlePress(context) : null,
      onLongPress: onLongPress != null ? () => handleLongPress(context) : null,
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
}

/// A smart outlined button that checks internet connectivity before executing actions.
///
/// This button wraps Flutter's [OutlinedButton] and adds automatic connectivity
/// checking. When pressed while offline, it shows configurable feedback instead
/// of executing the [onPressed] callback.
class SmartOutlinedButton extends BaseSmartButton {
  /// Creates a smart outlined button.
  ///
  /// The [onPressed] callback is only executed when internet connectivity is available.
  /// When offline, shows feedback based on [feedbackType] and calls [onOfflineAction] if provided.
  const SmartOutlinedButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    required super.child,
    super.feedbackType,
    super.offlineMessage,
    super.offlineTitle,
    super.onOfflineAction,
    super.requireWiFi,
    super.connectivityChecker,
  });

  @override
  Widget buildButton(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed != null ? () => handlePress(context) : null,
      onLongPress: onLongPress != null ? () => handleLongPress(context) : null,
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
}
