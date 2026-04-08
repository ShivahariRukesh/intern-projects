import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/ui/views/auth/auth_view.form.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends FormViewModel {
  final _apiService = locator<AuthService>();

  String get usernameField => usernameValue ?? '';
  String get passwordField => passwordValue ?? '';

  String loginKey = 'login-user';
  void getValues() {
    print("The submitted values are : $usernameField and $passwordField");
  }

  Future<void> loginUser() async {
    try {
      final result = await runBusyFuture(
        _apiService.handleLogin(
          username: usernameValue,
          password: passwordValue,
        ),
      );

      // handle success
    } catch (e) {
      setError(e); // UI reacts
    }

    // try {
    //   setBusy(true);
    //   final result =
    //       await runBusyFuture<Map<String, dynamic>>(

    //           _apiService.handleLogin(
    //     username: usernameValue,
    //     password: passwordValue,
    //   ));
    // } catch (err) {
    //   print("result error is $err");
    //   setError(true);
    // }
    // setBusy(false);
  }

  @override
  void onFutureError(error, Object? key) {
    // TODO: implement onFutureError
    super.onFutureError(error, key);
    print("Eror future is $error");
  }
}

class AuthFieldValidator {
  static String? validateUsername(String? value) {
    if (value != null && RegExp(r'^[a-zA-Z0-9_]{3,16}$').hasMatch(value)) {
      return null;
    } else {
      return "Enter a valid username";
    }
  }

  static String? validatePassword(String? value) {
    if (value != null &&
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(value)) {
      return null;
    } else {
      return "Enter a valid password";
    }
  }
}
