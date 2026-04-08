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

  Future<void> login({required int userId}) async {
    await _sharedPref.setBool('isUserLoggedIn', true);
    await _sharedPref.setInt('userId', userId);

    _isUserLoggedIn = true;
  }

  Future<void> logout() async {
    await _sharedPref.setBool('isUserLoggedIn', false);
    await _sharedPref.remove('userId');
    _isUserLoggedIn = false;
  }

  int? extractUserId() {
    return _sharedPref.getInt('userId');
  }

  Future<void> toggleThemeMode() async {
    isLightThemeMode = !isLightThemeMode;
    await _sharedPref.setBool(
        'isLightThemeMode', isLightThemeMode);
  }
}
