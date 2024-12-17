import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

// TODO: Add additional settings
// TODO: Add additional themes?
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeProvider.notifier);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Divider(),
            // TODO: Make a custom switch widget
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeMode == ThemeMode.dark,
              onChanged: (bool value) {
                themeNotifier
                    .setTheme(value ? ThemeMode.dark : ThemeMode.light);
              },
              secondary: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.nights_stay
                    : Icons.wb_sunny,
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
