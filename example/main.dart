import 'package:flutter/material.dart';
import 'package:smart_button/smart_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Button Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Wrap the entire app in SmartButtonTheme for global defaults
      home: SmartButtonTheme(
        data: const SmartButtonThemeData(
          feedbackType: OfflineFeedbackType.dialog,
          offlineTitle: 'No Connection',
          offlineMessage: 'Please check your internet and try again.',
        ),
        child: const MyHomePage(title: 'Smart Button Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Counter incremented! You are online.')),
    );
  }

  void _onOfflineAction() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Button was pressed while offline'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Smart buttons only work when you have internet connection:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 40),

              // Example 1: SmartButton with dialog feedback (uses theme defaults)
              SmartButton(
                onPressed: _incrementCounter,
                onOfflineAction: _onOfflineAction,
                child: const Text('Smart Elevated Button (Dialog)'),
              ),

              const SizedBox(height: 16),

              // Example 2: SmartTextButton with snackbar feedback (overrides theme)
              SmartTextButton(
                onPressed: _incrementCounter,
                feedbackType: OfflineFeedbackType.snackbar,
                offlineMessage: 'No internet! Counter not incremented.',
                onOfflineAction: _onOfflineAction,
                child: const Text('Smart Text Button (Snackbar)'),
              ),

              const SizedBox(height: 16),

              // Example 3: SmartOutlinedButton with no feedback
              SmartOutlinedButton(
                onPressed: _incrementCounter,
                feedbackType: OfflineFeedbackType.none,
                onOfflineAction: _onOfflineAction,
                child: const Text('Smart Outlined Button (No Feedback)'),
              ),

              const SizedBox(height: 16),

              // Example 4: SmartFilledButton (Material 3)
              SmartFilledButton(
                onPressed: _incrementCounter,
                onOfflineAction: _onOfflineAction,
                child: const Text('Smart Filled Button'),
              ),

              const SizedBox(height: 16),

              // Example 5: SmartIconButton
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('SmartIconButton: '),
                  SmartIconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: _incrementCounter,
                    tooltip: 'Increment (online only)',
                    feedbackType: OfflineFeedbackType.snackbar,
                    offlineMessage: 'Cannot increment while offline',
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Example 6: SmartButton with WiFi requirement
              SmartButton(
                onPressed: _incrementCounter,
                requireWiFi: true,
                offlineTitle: 'WiFi Required',
                offlineMessage: 'This feature requires a WiFi connection.',
                child: const Text('WiFi Only Button'),
              ),

              const SizedBox(height: 16),

              // Example 7: SmartButton with custom connectivity checker
              SmartTextButton(
                onPressed: _incrementCounter,
                connectivityChecker: () async {
                  // Simulate custom connectivity check
                  return true; // Always connected in this example
                },
                feedbackType: OfflineFeedbackType.snackbar,
                offlineMessage: 'Custom connectivity check failed.',
                child: const Text('Custom Connectivity Button'),
              ),

              const SizedBox(height: 40),
              const Text(
                'Try turning off your internet connection and pressing the buttons!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
