# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter package called `smart_button` that provides a Flutter button widget with all standard button properties plus built-in internet connectivity checking. When users interact with the button while offline, it shows an adaptive alert dialog or snack bar and prevents the onPressed/onTap actions from executing. The project follows standard Dart/Flutter package conventions and is in early development (version 0.0.1).

## Development Commands

### Testing
```bash
flutter test
```
Run all tests in the `test/` directory. The project uses `flutter_test` for unit testing.

### Linting and Analysis
```bash
flutter analyze
```
Static analysis using flutter_lints (version ^5.0.0) with Flutter-specific linting rules.

### Package Management
```bash
flutter pub get        # Install dependencies
flutter pub upgrade    # Update dependencies
flutter pub deps       # Show dependency tree
```

### Package Development
```bash
flutter packages pub publish --dry-run    # Test package publishing
flutter packages pub publish              # Publish to pub.dev
```

## Project Structure

```
lib/
├── smart_button.dart          # Main package entry point with Calculator class
test/
├── smart_button_test.dart     # Unit tests for the package
```

## Architecture Notes

- **Package Type**: Flutter package (not a plugin - no platform-specific code)
- **Core Widget**: SmartButton - extends standard Flutter button with connectivity awareness
- **Key Features**:
    - All standard Flutter button properties (onPressed, style, child, etc.)
    - Built-in internet connectivity checking before action execution
    - Configurable offline feedback via adaptive alert dialog or snack bar
    - Prevents onPressed/onTap execution when offline
- **Dependencies**: Will need connectivity checking package (e.g., connectivity_plus)
- **Testing Strategy**: Unit tests using flutter_test framework
- **Linting**: Uses flutter_lints package for code quality enforcement
- **Dart SDK**: Requires ^3.8.1, Flutter >=1.17.0

## Implementation Guidelines

- SmartButton should accept all standard button parameters
- Connectivity check should be performed before executing user callbacks
- Provide customizable offline notification options (dialog/snackbar)
- Maintain Flutter's standard button API for easy adoption
- Consider widget testing for connectivity scenarios

## Current State

The project contains template code that needs to be replaced with:
- SmartButton widget implementation
- Connectivity checking logic
- Adaptive UI feedback mechanisms
- Comprehensive tests for online/offline scenarios