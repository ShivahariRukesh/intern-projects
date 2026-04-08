import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ThemeService with ListenableServiceMixin {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeService() {
    listenToReactiveValues([_themeMode]);
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    notifyListeners();
  }
}
