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

  Future<void> loginUser() async {
    final result = await runBusyFuture(
      _apiService.loginUser(
        username: usernameValue,
        password: passwordValue,
      ),
    );

    if (result.success != null) {
      _sharedPreferenceService.login(
          userId: result.success!.data.id);
      _navigationService.replaceWithHomeView();
    } else {
      setError(
          result.error?.message ?? "Something went wrong");
    }
  }

  @override
  void onFutureError(error, Object? key) {
    super.onFutureError(error, key);
    print("Eror future is $error");
  }
}
