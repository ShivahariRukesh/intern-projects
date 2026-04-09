import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/utils/result_record.dart';
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

  Future<Result<bool>> login({required int userId}) async {
    try {
      await _sharedPref.setBool('isUserLoggedIn', true);
      await _sharedPref.setInt('userId', userId);
      _isUserLoggedIn = true;
      return (
        success: SuccessResponse(data: true),
        error: null
      );
    } catch (e) {
      debugPrint(
          "Unexpected error occurred when storing values during user login :$e");
      return (
        success: null,
        error: ErrorResponse(
            message: "Cannot store logged in credentials")
      );
    }
  }

  Future<Result<bool>> logout() async {
    try {
      await _sharedPref.setBool('isUserLoggedIn', false);
      await _sharedPref.remove('userId');
      _isUserLoggedIn = false;

      return (
        success: SuccessResponse(data: true),
        error: null
      );
    } catch (e) {
      return (
        error: ErrorResponse(
            message: "Cannot remove logged in credentials"),
        success: null
      );
    }
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
