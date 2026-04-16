import 'package:task_manager_with_api_sync/data/services/network/user_dio_service.dart';
import 'package:task_manager_with_api_sync/utils/result.dart';

class UserRepository {
  final UserDioService _dioService = UserDioService();

  Future<Result<Map<String, dynamic>>> authenticateUser({
    required String username,
    required String password,
  }) async {
    return await _dioService.loginUser(
      username: username,
      password: password,
    );
  }
}
