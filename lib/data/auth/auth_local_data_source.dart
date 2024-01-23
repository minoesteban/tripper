abstract class AuthLocalDataSource {
  String? currentUser();

  Future<void> saveToken(String token);

  String? getToken();

  Future<void> deleteToken();
}
