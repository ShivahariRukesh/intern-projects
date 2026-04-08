import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

class SharedPreferenceService
    implements InitializableDependency {
  late SharedPreferences _sharedPref;

  bool _isUserLoggedIn = false;
  bool get isUserLoggedIn => _isUserLoggedIn;

  bool isLightThemeMode = true;

  @override
  Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();

    _isUserLoggedIn =
        _sharedPref.getBool('isUserLoggedIn') ?? false;

    if (_sharedPref.containsKey('isLightThemeMode')) {
      isLightThemeMode =
          _sharedPref.getBool('isLightThemeMode')!;
    } else {
      isLightThemeMode = true;
      await _sharedPref.setBool('isLightThemeMode', true);
    }
  }

  Future<void> login() async {
    await _sharedPref.setBool('isUserLoggedIn', true);
    _isUserLoggedIn = true;
  }

  Future<void> logout() async {
    await _sharedPref.setBool('isUserLoggedIn', false);
    _isUserLoggedIn = false;
  }

  Future<void> toggleThemeMode() async {
    isLightThemeMode = !isLightThemeMode;
    await _sharedPref.setBool(
        'isLightThemeMode', isLightThemeMode);
  }
}
