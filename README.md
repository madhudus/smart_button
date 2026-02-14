# Smart Button

Flutter buttons with built-in internet connectivity checking. Automatically prevents actions and shows user feedback when offline.

## Features

- **Automatic connectivity checking** - Checks internet connection before executing button actions
- **Offline action prevention** - Prevents onPressed/onTap callbacks when no internet connection
- **Adaptive feedback** - Shows platform-appropriate dialogs or snackbars when offline
- **Drop-in replacement** - Supports all standard Flutter button properties
- **Five button types** - SmartButton, SmartTextButton, SmartOutlinedButton, SmartFilledButton, SmartIconButton
- **Configurable feedback** - Choose between dialog, snackbar, or no feedback
- **Global theming** - SmartButtonTheme sets defaults for all smart buttons in a subtree
- **Advanced connectivity options** - Require WiFi only or implement custom connectivity checks

## Getting started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  smart_button: ^1.1.0
```

Then run:
```bash
flutter pub get
```

### Platform Setup

Smart Button uses [connectivity_plus](https://pub.dev/packages/connectivity_plus) under the hood.

**Android**: Add the following permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

**iOS / macOS / Web / Linux / Windows**: No additional setup required.

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
    print('Connected! Performing online action...');
  },
  child: Text('Smart Button'),
)

// Instead of TextButton
SmartTextButton(
  onPressed: () => print('Online action executed'),
  child: Text('Smart Text Button'),
)

// Instead of OutlinedButton
SmartOutlinedButton(
  onPressed: () => print('Online action executed'),
  child: Text('Smart Outlined Button'),
)

// Instead of FilledButton (Material 3)
SmartFilledButton(
  onPressed: () => print('Online action executed'),
  child: Text('Smart Filled Button'),
)

// Instead of IconButton
SmartIconButton(
  icon: Icon(Icons.refresh),
  onPressed: () => print('Refreshing...'),
  tooltip: 'Refresh',
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
    print('User tried to use feature while offline');
  },
  child: Text('Upload Data'),
)
```

### SmartIconButton

A connectivity-aware wrapper for Flutter's `IconButton`:

```dart
SmartIconButton(
  icon: Icon(Icons.cloud_upload),
  onPressed: () => uploadFile(),
  tooltip: 'Upload',
  iconSize: 32,
  color: Colors.blue,
  feedbackType: OfflineFeedbackType.snackbar,
  offlineMessage: 'Cannot upload while offline',
)
```

### SmartFilledButton

A connectivity-aware wrapper for Flutter's `FilledButton` (Material 3):

```dart
SmartFilledButton(
  onPressed: () => submitForm(),
  feedbackType: OfflineFeedbackType.dialog,
  offlineMessage: 'Please connect to internet to submit',
  child: Text('Submit'),
)
```

### SmartButtonTheme

Set global defaults for all smart buttons in a subtree:

```dart
SmartButtonTheme(
  data: SmartButtonThemeData(
    feedbackType: OfflineFeedbackType.snackbar,
    offlineMessage: 'You are offline',
    offlineTitle: 'No Connection',
  ),
  child: Column(
    children: [
      // Uses theme defaults (snackbar feedback)
      SmartButton(
        onPressed: () => doSomething(),
        child: Text('Uses Theme Defaults'),
      ),
      // Overrides theme (uses dialog instead)
      SmartButton(
        onPressed: () => doSomething(),
        feedbackType: OfflineFeedbackType.dialog,
        child: Text('Overrides Theme'),
      ),
    ],
  ),
)
```

Theme values follow a **widget > theme > default** fallback chain. Explicit widget parameters always win.

### Advanced Connectivity Options

For more control over connectivity checking:

```dart
// Require WiFi connection only
SmartButton(
  onPressed: () => performOnlineAction(),
  requireWiFi: true,
  child: Text('WiFi Only Button'),
)

// Custom connectivity checker
SmartButton(
  onPressed: () => performOnlineAction(),
  connectivityChecker: () async {
    // Your custom logic here
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

## Troubleshooting

**Button always shows offline on Android**
Make sure you have the `ACCESS_NETWORK_STATE` permission in your `AndroidManifest.xml`. See the [Platform Setup](#platform-setup) section.

**Custom connectivity checker not being used**
Check that you're passing the function correctly. The `connectivityChecker` parameter expects `Future<bool> Function()`. If using `SmartButtonTheme`, make sure the theme is an ancestor of the button in the widget tree.

**Theme defaults not applying**
Ensure `SmartButtonTheme` is placed above the buttons in the widget tree. Use `SmartButtonTheme.of(context)` to verify the theme is accessible from a given context.

## Requirements

- Flutter >=1.17.0
- Dart >=3.8.1

## Versioning

This package follows [Semantic Versioning](https://semver.org/):
- Major version (1.x.x) - Breaking changes
- Minor version (x.1.x) - New features
- Patch version (x.x.1) - Bug fixes

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
