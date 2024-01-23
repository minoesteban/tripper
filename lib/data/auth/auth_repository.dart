abstract class AuthRepository {
  String? getToken();

  Future<void> saveToken(String token);

  Future<void> deleteToken();

  Stream<bool> get isSignedInStream;

  void dispose();
}
