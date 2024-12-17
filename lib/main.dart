import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/main_screen.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.red, foregroundColor: Colors.white),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black, foregroundColor: Colors.white),
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Flutter Test',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const MainScreen(),
    );
  }
}
