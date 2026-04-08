import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

class SharedPreferenceService
    implements InitializableDependency {
  late SharedPreferences _sharedPref;

  bool _isUserLoggedIn = false;
  bool get isUserLoggedIn => _isUserLoggedIn;

  @override
  Future<void> init() async {
    _sharedPref = await SharedPreferences.getInstance();

    _isUserLoggedIn =
        _sharedPref.getBool('isUserLoggedIn') ?? false;
  }

  Future<void> login() async {
    await _sharedPref.setBool('isUserLoggedIn', true);
    _isUserLoggedIn = true;
  }

  Future<void> logout() async {
    await _sharedPref.setBool('isUserLoggedIn', false);
    _isUserLoggedIn = false;
  }
}
