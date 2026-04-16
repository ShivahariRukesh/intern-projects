import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/repositories/auth_repository.dart';
import 'package:social_media_app/ui/views/auth/auth_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends FormViewModel {
  final AuthRepository _authRepository = AuthRepository();
  final NavigationService _navigationService = locator<NavigationService>();

  String get usernameField => usernameValue ?? '';
  String get passwordField => passwordValue ?? '';

  bool isPasswordObscured = true;
  Future<void> loginUser() async {
    final result = await runBusyFuture(_authRepository.loginUser(
        username: usernameField, password: passwordField));

    if (result.success != null) {
      _navigationService.replaceWithHomeView();
    } else {
      setError(result.error?.message ?? "Something went wrong while logging");
    }
  }

  void toggleObscurePassword() {
    isPasswordObscured = !isPasswordObscured;
    rebuildUi();
  }
}
