import 'package:animeworld/core/helpers/database_data/database_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    _initializeTheme();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> _initializeTheme() async {
    final isDark = await DatabaseHelper.instance.isDarkMode;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> setThemeMode({required bool isDarkMode}) async {
    await DatabaseHelper.instance.setDarkMode(isDarkMode);
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<bool> getIsDarkMode() async {
    return await DatabaseHelper.instance.isDarkMode;
  }
}