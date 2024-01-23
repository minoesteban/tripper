import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripper/data/auth/auth_local_data_source.dart';

const _currentUserKey = 'current_user';
const _tokenKey = 'token';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this.storage);

  final SharedPreferences storage;

  @override
  String? currentUser() => storage.getString(_currentUserKey);

  @override
  Future<void> saveToken(String token) => storage.setString(_tokenKey, token);

  @override
  String? getToken() => storage.getString(_tokenKey);

  @override
  Future<void> deleteToken() => storage.remove(_tokenKey);
}
