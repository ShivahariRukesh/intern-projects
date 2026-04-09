import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/theme_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _themeService = locator<ThemeService>();
  final _sharedPreferenceService =
      locator<SharedPreferenceService>();
  final _navigationPreferenceService =
      locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _postService = locator<PostService>();

  UserModel? loggedInUser;
  List<PostModel> postList = [];

  Future<void> getAllPost() async {
    setBusy(true);
    try {
      final result = await _postService.fetchAllPosts();
      postList = result;
      print("Get all posts $result");

      rebuildUi();
    } catch (err) {
      setError(err);
    }
    setBusy(false);
  }

  void toggleTheme() async {
    _themeService.toggleTheme();
    await _sharedPreferenceService.toggleThemeMode();
  }

  Future<void> handleLogout() async {
    await runBusyFuture(_authService.logoutUser());

    await _sharedPreferenceService.logout();

    _navigationPreferenceService.replaceWithAuthView();
  }

  Future<void> getAllUsers() async {
    final res = await _authService.fetchAllUsers();
  }

  Future<void> getLoggedInUser() async {
    try {
      setBusy(true);
      final int? userId =
          _sharedPreferenceService.extractUserId();
      if (userId == null) {
        throw Exception('Cannot access logged in user');
      }
      final UserModel user = await _authService
          .fetchLoggedInUser(userId: userId);
      loggedInUser = user;

      rebuildUi();
    } catch (err) {
      setError(err);
    }
    setBusy(false);
  }
}
