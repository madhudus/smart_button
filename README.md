# Smart Button

Flutter buttons with built-in internet connectivity checking. Automatically prevents actions and shows user feedback when offline.

## Features

- Automatic connectivity checking - Checks internet connection before executing button actions
- Offline action prevention - Prevents onPressed/onTap callbacks when no internet connection
- Adaptive feedback - Shows platform-appropriate dialogs or snackbars when offline
- Drop-in replacement - Supports all standard Flutter button properties
- Three button types - SmartButton (ElevatedButton), SmartTextButton (TextButton), SmartOutlinedButton (OutlinedButton)
- Configurable feedback - Choose between dialog, snackbar, or no feedback
- Advanced connectivity options - Require WiFi only or implement custom connectivity checks
- Production-ready - Stable 1.0.0 release with comprehensive test coverage

## Getting started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  smart_button: ^1.0.3
```

Then run:
```bash
flutter pub get
```

## Usage

Import the package:
```dart
import 'package:smart_button/smart_button.dart';
```

### Basic Usage

Replace your regular Flutter buttons with Smart buttons:

```dart
// Instead of ElevatedButton
SmartButton(
  onPressed: () {
    // This will only execute if internet is available
    print('Connected! Performing online action...');
  },
  child: Text('Smart Button'),
)

// Instead of TextButton  
SmartTextButton(
  onPressed: () {
    print('Online action executed');
  },
  child: Text('Smart Text Button'),
)

// Instead of OutlinedButton
SmartOutlinedButton(
  onPressed: () {
    print('Online action executed');
  },
  child: Text('Smart Outlined Button'),
)
```

### Customizing Offline Feedback

Choose how users are notified when offline:

```dart
SmartButton(
  onPressed: () => performOnlineAction(),
  feedbackType: OfflineFeedbackType.snackbar, // or .dialog, .none
  offlineMessage: 'Please check your internet connection and try again.',
  offlineTitle: 'No Internet Connection',
  onOfflineAction: () {
    // Optional: Custom action when button is pressed offline
    print('User tried to use feature while offline');
  },
  child: Text('Upload Data'),
)
```

### Advanced Connectivity Options

For more control over connectivity checking:

```dart
// Require WiFi connection only
SmartButton(
  onPressed: () => performOnlineAction(),
  requireWiFi: true, // Only allows WiFi connections
  child: Text('WiFi Only Button'),
)

// Custom connectivity checker
SmartButton(
  onPressed: () => performOnlineAction(),
  connectivityChecker: () async {
    // Your custom logic here
    // Return true if connection is acceptable
    return await checkCustomConnectivity();
  },
  child: Text('Custom Check Button'),
)
```

### Feedback Types

- `OfflineFeedbackType.dialog` - Shows an adaptive alert dialog (default)
- `OfflineFeedbackType.snackbar` - Shows a snackbar notification
- `OfflineFeedbackType.none` - No visual feedback, only prevents action

### All Standard Button Properties Supported

Smart buttons support all the same properties as their Flutter counterparts:

```dart
SmartButton(
  onPressed: () => doSomething(),
  onLongPress: () => doSomethingElse(),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  focusNode: myFocusNode,
  autofocus: true,
  child: Text('Styled Smart Button'),
)
```

## How It Works

1. When a Smart button is pressed, it first checks internet connectivity using the `connectivity_plus` package
2. If connected, the button executes the provided `onPressed` callback normally
3. If offline, the button:
   - Prevents the `onPressed` callback from executing
   - Shows the configured feedback (dialog/snackbar/none)
   - Optionally calls the `onOfflineAction` callback

## Requirements

- Flutter >=1.17.0
- Dart >=3.8.1

## Versioning

This package follows [Semantic Versioning](https://semver.org/):
- Major version (1.x.x) - Breaking changes
- Minor version (x.1.x) - New features
- Patch version (x.x.1) - Bug fixes

With the release of version 1.0.0, this package is considered stable and production-ready.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
