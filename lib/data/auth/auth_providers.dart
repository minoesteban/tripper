import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/core/storage/local_storage.dart';
import 'package:tripper/data/auth/auth_local_data_source.dart';
import 'package:tripper/data/auth/auth_local_data_source_impl.dart';
import 'package:tripper/data/auth/auth_repository.dart';
import 'package:tripper/data/auth/auth_repository_impl.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dataSource = ref.read(authLocalDataSourceProvider);
  final repository = AuthRepositoryImpl(dataSource);

  return repository;
}

@riverpod
@visibleForTesting
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  final localStorage = ref.read(localStorageProvider);
  return AuthLocalDataSourceImpl(localStorage);
}
