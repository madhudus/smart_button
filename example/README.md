# Smart Button Example

This example demonstrates how to use the smart_button package in a Flutter app.

## Features Demonstrated

- **SmartButton**: Elevated button with dialog feedback when offline
- **SmartTextButton**: Text button with snackbar feedback when offline  
- **SmartOutlinedButton**: Outlined button with no visual feedback when offline
- **Custom offline actions**: Shows how to handle offline button presses
- **Different feedback types**: Dialog, snackbar, and none

## Running the Example

1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Testing Offline Behavior

To test the offline functionality:

1. Run the app on a device or simulator
2. Turn off internet connection (WiFi and mobile data)
3. Press the different smart buttons to see their offline behavior
4. Turn internet back on to see normal button functionality

Each button type shows different feedback when pressed offline, demonstrating the flexibility of the smart_button package.