import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String get username =>
      _preferences.getString('username') ?? '';

  static set username(String value) =>
      _preferences.setString('username', value);

  static String get email =>
      _preferences.getString('email') ?? '';

  static set email(String value) =>
      _preferences.setString('email', value);

  static bool get isLoggedIn =>
      bool.tryParse(
        _preferences.getString('isLoggedIn') ?? 'false',
      ) ??
      false;

  static set isLoggedIn(bool value) => _preferences
      .setString('isLoggedIn', value.toString());
}
