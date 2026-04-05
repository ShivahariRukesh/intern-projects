import 'package:flutter/widgets.dart';
import 'package:task_manager_with_api_sync/data/repositories/user_repository.dart';
import 'package:task_manager_with_api_sync/utils/result.dart';
import 'package:task_manager_with_api_sync/utils/shared_preferences_service.dart';

class AuthenticateViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();

  String? username;
  String? email;
  bool isLoggedIn = false;

  Future<void> loginUser({
    required String username,
    required String password,
  }) async {
    final Result<Map<String, dynamic>> result =
        await userRepository.authenticateUser(
          username: username,
          password: password,
        );

    switch (result) {
      case Success<Map<String, dynamic>>(
        :final Map<String, dynamic> data,
      ):
        PrefService.username = data['username'];
        username = data['username'];
        PrefService.email = data['email'];
        email = data['email'];
        isLoggedIn = true;
      case Failure(:final String errorMessage):
    }

    notifyListeners();
  }

  Future<void> logoutUser() async {
    PrefService.username = '';
    username = '';
    PrefService.email = '';
    email = '';
    isLoggedIn = false;
    notifyListeners();
  }
}
