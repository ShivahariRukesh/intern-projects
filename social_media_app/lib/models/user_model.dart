class UserModel {
  final int id;
  final String username;
  final String email;
  final String accessToken;

  UserModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.accessToken});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        id: jsonData["id"],
        username: jsonData["username"],
        email: jsonData["email"],
        accessToken: jsonData["accessToken"] ?? '');
  }
}
