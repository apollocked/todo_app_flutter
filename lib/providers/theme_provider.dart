import 'package:flutter/material.dart';
import 'package:todo_app/services/storage_service.dart';

/// Provider for managing app theme state with persistence.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isInitialized = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isInitialized => _isInitialized;

  /// Load saved theme from storage.
  Future<void> loadTheme() async {
    final isDark = await StorageService.loadTheme();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _isInitialized = true;
    notifyListeners();
  }

  /// Toggle theme and persist to storage.
  Future<void> toggleTheme(bool isOn) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    await StorageService.saveTheme(isOn);
    notifyListeners();
  }
}
