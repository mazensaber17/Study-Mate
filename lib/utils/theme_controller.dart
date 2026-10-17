import 'package:flutter/material.dart';

import 'local_storage.dart';

class ThemeController extends ChangeNotifier {
  ThemeController._();

  static final ThemeController instance = ThemeController._();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> initialize() async {
    final savedTheme = AppLocalStorage.themeMode;
    if (savedTheme == null) return;

    _themeMode = savedTheme ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> setDarkMode(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await AppLocalStorage.saveThemeMode(isDark);
  }
}
