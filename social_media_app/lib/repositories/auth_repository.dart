import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/utils/result_record.dart';

class AuthRepository {
  final AuthService _authService = locator<AuthService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  Future<Result> loginUser(
      {required String username,
      required String password}) async {
    final authResult = await _authService.loginUser(
      username: username,
      password: password,
    );

    if (authResult.success != null) {
      final prefResult = await _sharedPreferenceService
          .login(userId: authResult.success!.data.id);

      if (prefResult.success != null) {
        return prefResult;
      } else {
        return (
          success: null,
          error: ErrorResponse(
              message: prefResult.error!.message)
        );
      }
    } else {
      return (success: null, error: authResult.error);
    }
  }

  Future<Result> logoutUser() async {
    await _authService.logoutUser();

    final prefResult =
        await _sharedPreferenceService.logout();
    if (prefResult.success != null) {
      return prefResult;
    } else {
      return (success: null, error: prefResult.error);
    }
  }
}
