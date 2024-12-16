# Flutter Test App

A toy project to learn about building an application using the Flutter & Dart ecosystem.

## Getting Started

This project is a starting point for a Flutter application built using the [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) extension in VS Code.

After installing the Flutter extension in VS Code, you can hit `cmd + shift + p` to open the command palette and run the `Flutter: New Project` command. This will create a new Flutter project in the directory of your choosing

Note: If you don't have the Flutter SDK installed, you will be prompted to install it. I recommend adding the SDK to your PATH so you can use the `flutter` command in the terminal

You can also achieve this via the CLI by running the following command in the terminal:

```bash
flutter create `YOUR_PROJECT_NAME`
```

### Flutter SDK Installation

You can install the Flutter SDK by following the instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).

### Adding Flutter SDK to PATH

To add the Flutter SDK to your PATH, you can add the following line to your `.zshrc` file in your user home directory:

```
export PATH="$PATH:/PATH_TO_YOUR_FLUTTER_SDK/bin"
```

## Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- https://pub.dev/
- https://flutter.dev/multi-platform
- [Riverpod](https://riverpod.dev/)
  - Provider package for Flutter

## Running the App

To run the app, you can use the `Run and Debug` tab & hit the `Run and Debug` button when `main.dart` is the current tab in VS Code or use the following CLI command:

```bash
flutter run
```

Follow the command line instructions to run the app on a simulator or device and the different options available to you.

## Flutter CLI Commands

While the `flutter run` command is running, you can use the following commands to interact with the app:

- `r` - Hot reload -> reloads the app without restarting it and preserves the app state
- `R` - Hot restart -> restarts the app and resets the app state

<!-- TODO: Write about this command clearing the cache -->

## Flutter Clean

<!-- TODO: Write about potential issues w/ cocoapods when using `shared_preferences` and how to resolve -->

## TODOs

- [] API Setup
  - Consume and utilize a REST API
    - https://the-one-api.dev/
- Improve TODO list functionality
- Add weather screen
  - Consume Openweather API
- Add a game - something simple
- Add a pomodoro screen
- Add basic user settings screen
- Add additional settings
