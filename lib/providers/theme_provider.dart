import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  // TODO: Utilize SharedPreferencesAsync or SharedPreferencesWithCache -> SharedPreferences will be deprecated
  // https://github.com/flutter/packages/tree/main/packages/shared_preferences/shared_preferences#sharedpreferences-vs-sharedpreferencesasync-vs-sharedpreferenceswithcache
  Future<void> _loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme') ?? 0;
    state = ThemeMode.values[themeIndex];
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', themeMode.index);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
