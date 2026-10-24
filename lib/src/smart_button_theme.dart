import 'package:flutter/material.dart';
import 'offline_feedback_type.dart';

/// Theme data class holding default values for smart buttons.
///
/// Use this with [SmartButtonTheme] to set global defaults that apply
/// to all smart buttons in the subtree.
///
/// ```dart
/// SmartButtonTheme(
///   data: SmartButtonThemeData(
///     feedbackType: OfflineFeedbackType.snackbar,
///     offlineMessage: 'No internet connection',
///   ),
///   child: MyApp(),
/// )
/// ```
class SmartButtonThemeData {
  /// The default feedback type for all smart buttons.
  final OfflineFeedbackType? feedbackType;

  /// The default offline message for all smart buttons.
  final String? offlineMessage;

  /// The default offline dialog title for all smart buttons.
  final String? offlineTitle;

  /// The default WiFi requirement for all smart buttons.
  final bool? requireWiFi;

  /// The default custom connectivity checker for all smart buttons.
  final Future<bool> Function()? connectivityChecker;

  /// Creates a theme data with the given defaults.
  ///
  /// All fields are optional. When null, individual buttons will use their
  /// own built-in defaults.
  const SmartButtonThemeData({
    this.feedbackType,
    this.offlineMessage,
    this.offlineTitle,
    this.requireWiFi,
    this.connectivityChecker,
  });

  /// Creates a copy of this theme data with the given fields replaced.
  SmartButtonThemeData copyWith({
    OfflineFeedbackType? feedbackType,
    String? offlineMessage,
    String? offlineTitle,
    bool? requireWiFi,
    Future<bool> Function()? connectivityChecker,
  }) {
    return SmartButtonThemeData(
      feedbackType: feedbackType ?? this.feedbackType,
      offlineMessage: offlineMessage ?? this.offlineMessage,
      offlineTitle: offlineTitle ?? this.offlineTitle,
      requireWiFi: requireWiFi ?? this.requireWiFi,
      connectivityChecker: connectivityChecker ?? this.connectivityChecker,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SmartButtonThemeData &&
        other.feedbackType == feedbackType &&
        other.offlineMessage == offlineMessage &&
        other.offlineTitle == offlineTitle &&
        other.requireWiFi == requireWiFi &&
        other.connectivityChecker == connectivityChecker;
  }

  @override
  int get hashCode => Object.hash(
    feedbackType,
    offlineMessage,
    offlineTitle,
    requireWiFi,
    connectivityChecker,
  );
}

/// An inherited widget that provides [SmartButtonThemeData] to descendant
/// smart buttons.
///
/// Wrap your widget tree (or part of it) with [SmartButtonTheme] to set
/// default values for all smart buttons underneath:
///
/// ```dart
/// SmartButtonTheme(
///   data: SmartButtonThemeData(
///     feedbackType: OfflineFeedbackType.snackbar,
///     offlineMessage: 'You are offline',
///     offlineTitle: 'Offline',
///   ),
///   child: Column(
///     children: [
///       SmartButton(onPressed: () {}, child: Text('Uses theme defaults')),
///       SmartButton(
///         onPressed: () {},
///         feedbackType: OfflineFeedbackType.dialog, // overrides theme
///         child: Text('Uses dialog instead'),
///       ),
///     ],
///   ),
/// )
/// ```
class SmartButtonTheme extends InheritedWidget {
  /// The theme data to provide to descendant smart buttons.
  final SmartButtonThemeData data;

  /// Creates a smart button theme.
  const SmartButtonTheme({super.key, required this.data, required super.child});

  /// Returns the nearest [SmartButtonThemeData] ancestor, or null if none exists.
  static SmartButtonThemeData? of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<SmartButtonTheme>();
    return theme?.data;
  }

  @override
  bool updateShouldNotify(SmartButtonTheme oldWidget) {
    return data != oldWidget.data;
  }
}
