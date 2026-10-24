## 1.1.1

* **Changed: Connectivity check failures are treated as offline** - If a custom `connectivityChecker` or the `connectivity_plus` plugin throws, the error is reported via `FlutterError.reportError` and the button follows the offline path (feedback is shown and `onOfflineAction` runs). Previously the error escaped the tap handler and neither callback ran
* **Fixed: Repeated offline taps no longer queue snackbars** - A new offline snackbar replaces the visible one instead of stacking behind it
* **Fixed: `SmartButtonTheme` rebuilds** - `SmartButtonThemeData` now implements `==` and `hashCode`, so dependent buttons only rebuild when theme values actually change
* **Improved: Localized OK labels** - The offline dialog and snackbar actions use `MaterialLocalizations.okButtonLabel` instead of a hardcoded "OK"
* **Improved: Shared connectivity flow** - Added `ConnectivityHandler.runIfConnected()`, used by all smart buttons, plus public `kDefaultOfflineMessage` and `kDefaultOfflineTitle` constants
* **Improved: Library documentation** - The library-level doc comment is now attached to the library and shown by dartdoc
* **Maintenance: Dependencies** - Updated `connectivity_plus` to `^7.3.2` and set the Flutter SDK constraint to `>=3.32.0` (matching the Dart `^3.8.1` requirement)
* **Maintenance: Example is now published** - The `example/` directory is included in the package for pub.dev

## 1.1.0

* **New: SmartIconButton** - Connectivity-aware wrapper for Flutter's IconButton with full API support (icon, iconSize, tooltip, splashRadius, etc.)
* **New: SmartFilledButton** - Connectivity-aware wrapper for Flutter's FilledButton (Material 3)
* **New: SmartButtonTheme** - InheritedWidget for setting global defaults (feedbackType, offlineMessage, offlineTitle, requireWiFi, connectivityChecker) across all smart buttons in a subtree
* **New: ConnectivityHandler** - Extracted shared connectivity logic into a reusable utility, reducing code duplication between BaseSmartButton and SmartIconButton
* **Improved: Theme fallback system** - All connectivity parameters (feedbackType, offlineMessage, offlineTitle, requireWiFi, connectivityChecker) now resolve through a widget → theme → default fallback chain
* **Improved: Comprehensive test suite** - Rewritten tests covering all 5 button types, connectivity blocking, dialog/snackbar/none feedback, onOfflineAction callbacks, onLongPress blocking, theme defaults, theme overrides, and nested themes
* **Improved: README** - Added platform setup, SmartIconButton/SmartFilledButton/SmartButtonTheme docs, and troubleshooting section
* **Improved: pubspec.yaml** - Added topics metadata for pub.dev discoverability

## 1.0.3

* **Maintenance & Package Quality** - Updated documentation and configuration
* Updated installation documentation to reflect current version
* Updated LICENSE copyright year to 2024-2025
* Removed incorrect .gitignore entry for pubspec.lock (following modern Dart best practices)
* Verified package publication configuration with dry-run tests

## 1.0.2

* **Documentation & Code Quality** - Improved pub.dev score
* Added comprehensive dartdoc comments for all public API elements in BaseSmartButton
* Fixed Dart formatting issues in base_smart_button.dart and smart_button_widget.dart
* Improved documentation coverage from 45.7% to complete coverage of public APIs
* Package now passes all static analysis checks with 0 warnings

## 1.0.1

* Fixed pubspec.yaml schema validation issue
* Updated flutter configuration in pubspec.yaml

## 1.0.0

* **Major Release** - Production-ready version with enhanced features
* Added `requireWiFi` parameter to enforce WiFi-only connections
* Added `connectivityChecker` parameter for custom connectivity logic
* Refactored code to reduce duplication using a base class
* Improved test coverage for new features
* Updated documentation and examples
* Bumped to stable 1.0.0 version for production use

## 0.0.4

* **Enhancements** - Added advanced connectivity options
* Added `requireWiFi` parameter to enforce WiFi-only connections
* Added `connectivityChecker` parameter for custom connectivity logic
* Refactored code to reduce duplication using a base class
* Improved test coverage for new features
* Updated documentation and examples

## 0.0.3

* **Code Quality** - Final formatting fixes
* Fixed remaining Dart formatting issues for perfect static analysis score
* Verified GitHub issues URL accessibility

## 0.0.2

* **Documentation & Examples** - Improved pub.dev score
* Added comprehensive dartdoc comments for all public API elements
* Created example app demonstrating all smart button types and feedback options
* Fixed Dart formatting issues
* Improved code documentation and API discoverability

## 0.0.1

* **Initial Release** - Smart Button package for Flutter
* Added `SmartButton` - ElevatedButton with connectivity checking
* Added `SmartTextButton` - TextButton with connectivity checking
* Added `SmartOutlinedButton` - OutlinedButton with connectivity checking
* Implemented automatic internet connectivity verification before button actions
* Added configurable offline feedback options:
  - Adaptive alert dialogs
  - Snackbar notifications
  - No feedback option
* Support for all standard Flutter button properties
* Custom offline messages and titles
* Optional offline action callbacks
* Comprehensive test coverage
* Full documentation and examples
