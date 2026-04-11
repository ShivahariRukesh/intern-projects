import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/repositories/auth_repository.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/theme_service.dart';
import 'package:social_media_app/utils/result_record.dart';
import 'package:social_media_app/utils/shuffle_list.dart';
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
  final _authRepository = AuthRepository();

  UserModel? loggedInUser;
  List<PostModel> postList = [];
  List<PostModel> storyList = [];

  Map<int, String> usernameMap = {};

  Future<void> getAllPost() async {
    setBusy(true);
    final result = await _postService.fetchAllPosts();
    if (result.success != null) {
      postList = result.success!.data;
      storyList = handleShuffleList<PostModel>(postList);
    } else {
      setError(result.error?.message ??
          "Unexpected Error Occurred");
    }
    setBusy(false);
  }

  void toggleTheme() async {
    _themeService.toggleTheme();
    await _sharedPreferenceService.toggleThemeMode();
  }

  Future<void> handleLogout() async {
    final result =
        await runBusyFuture(_authRepository.logoutUser());
    if (result.success != null) {
      _navigationPreferenceService.replaceWithAuthView();
    } else {
      setError(result.error?.message ??
          'Unexpected Error Occurred When Logging Out');
    }
    setBusy(false);
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
      final Result<UserModel> result = await _authService
          .fetchLoggedInUser(userId: userId);

      if (result.success != null) {
        loggedInUser = result.success!.data;
        rebuildUi();
      } else {
        setError(result.error?.message ??
            "Unexpected Error Occurred");
      }
    } catch (err) {
      setError(err);
    }
    setBusy(false);
  }

  Future<void> getUserById() async {
    setBusy(true);

    final result =
        await _authRepository.getUsernameFromPostId();

    if (result.success != null) {
      usernameMap = result.success!.data;
    } else {
      setError(result.error?.message ??
          "Unexpected Error Occurred When Fetching User");
    }

    setBusy(false);
  }
}
