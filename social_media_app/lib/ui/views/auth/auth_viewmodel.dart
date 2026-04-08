import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/ui/views/auth/auth_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends FormViewModel {
  final _apiService = locator<AuthService>();
  final _sharedPreferenceService =
      locator<SharedPreferenceService>();
  final _navigationService = locator<NavigationService>();

  String get usernameField => usernameValue ?? '';
  String get passwordField => passwordValue ?? '';

  String loginKey = 'login-user';

  Future<void> loginUser() async {
    try {
      final result = await runBusyFuture(
        _apiService.loginUser(
          username: usernameValue,
          password: passwordValue,
        ),
      );
      if (result.containsKey('accessToken')) {
        _sharedPreferenceService.login();
        _navigationService.replaceWithHomeView();
      }

      // handle success
    } catch (e) {
      setError(e); // UI reacts
    }
    setBusy(false);

    // try {
    //   setBusy(true);
    //   final result =
    //       await runBusyFuture<Map<String, dynamic>>(

    //           _apiService.loginUser(
    //     username: usernameValue,
    //     password: passwordValue,
    //   ));
    // } catch (err) {
    //   print("result error is $err");
    //   setError(true);
    // }
  }

  @override
  void onFutureError(error, Object? key) {
    // TODO: implement onFutureError
    super.onFutureError(error, key);
    print("Eror future is $error");
  }
}
