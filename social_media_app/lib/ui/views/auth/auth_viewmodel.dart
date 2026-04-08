import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/ui/views/auth/auth_view.form.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends FormViewModel {
  final _apiService = locator<AuthService>();

  String get usernameField => usernameValue ?? '';
  String get passwordField => passwordValue ?? '';

  String loginKey = 'login-user';

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
