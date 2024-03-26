import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tripper/data/auth/auth_local_data_source.dart';
import 'package:tripper/domain/auth/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authLocalDataSource) {
    _isSignedInStream.sink.add(isSignedIn);
  }

  final AuthLocalDataSource _authLocalDataSource;

  final _isSignedInStream = BehaviorSubject<bool>();

  bool get isSignedIn => _authLocalDataSource.getToken() != null;

  @override
  Stream<bool> get isSignedInStream => _isSignedInStream.stream;

  @override
  Future<void> deleteToken() async {
    await _authLocalDataSource.deleteToken();
    _isSignedInStream.add(isSignedIn);

    return;
  }

  @override
  String? getToken() => _authLocalDataSource.getToken();

  @override
  Future<void> saveToken(String token) async {
    await _authLocalDataSource.saveToken(token);
    _isSignedInStream.add(isSignedIn);
  }
}
