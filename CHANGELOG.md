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
