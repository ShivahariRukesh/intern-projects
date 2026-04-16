import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/post_service.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/utils/result_record.dart';

class AuthRepository {
  final AuthService _authService = locator<AuthService>();
  final PostService _postService = locator<PostService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  Future<Result> loginUser(
      {required String username, required String password}) async {
    final authResult = await _authService.loginUser(
      username: username,
      password: password,
    );

    if (authResult.success != null) {
      final prefResult = await _sharedPreferenceService.login(
          userId: authResult.success!.data.id);

      if (prefResult.success != null) {
        return prefResult;
      } else {
        return (
          success: null,
          error: ErrorResponse(message: prefResult.error!.message)
        );
      }
    } else {
      return (success: null, error: authResult.error);
    }
  }

  Future<Result> logoutUser() async {
    await _authService.logoutUser();

    final prefResult = await _sharedPreferenceService.logout();
    if (prefResult.success != null) {
      return prefResult;
    } else {
      return (success: null, error: prefResult.error);
    }
  }

  Future<Result<Map<int, String>>> getUsernameFromPostId() async {
    final Map<int, String> usernameById = {};

    final postResult = await _postService.fetchAllPosts();

    if (postResult.success != null) {
      final userResult = await _authService.fetchAllUsers();
      if (userResult.success != null) {
        final postResultData = postResult.success!.data;
        final userResultData = userResult.success!.data;
        for (PostModel post in postResultData) {
          for (UserModel user in userResultData) {
            if (post.userId == user.id) {
              usernameById[user.id] = user.username;
              break;
            }
          }
        }
      } else {
        return (
          error: ErrorResponse(
              message:
                  userResult.error?.message ?? "Couldn't get user from post"),
          success: null
        );
      }
    } else {
      return (error: postResult.error, success: null);
    }
    return (success: SuccessResponse(data: usernameById), error: null);
  }

  // Future<Result<Map<int, String>>> getUsernameFromPostId() async {
  //   final Map<int, String> usernameById = {};

  //   final postResult = await _postService.fetchAllPosts();

  //   if (postResult.success != null) {
  //     final postResultData = postResult.success!.data;
  //     for (int i = 0; i < postResultData.length; i++) {
  //       final usernameResult = await _authService.fetchLoggedInUser(
  //           userId: postResultData[i].userId);

  //       if (usernameResult.success != null) {
  //         usernameById[postResultData[i].userId] =
  //             usernameResult.success?.data.username ?? '';
  //       } else {
  //         return (
  //           error: ErrorResponse(
  //               message: usernameResult.error?.message ??
  //                   "Couldn't get user from post"),
  //           success: null
  //         );
  //       }
  //     }
  //   } else {
  //     return (error: postResult.error, success: null);
  //   }
  //   return (success: SuccessResponse(data: usernameById), error: null);
  // }
}
