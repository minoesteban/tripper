import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/core/storage/core_providers.dart';
import 'package:tripper/data/auth/auth_local_data_source.dart';
import 'package:tripper/data/auth/auth_local_data_source_impl.dart';
import 'package:tripper/data/auth/auth_repository.dart';
import 'package:tripper/data/auth/auth_repository_impl.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
Future<AuthRepository> authRepository(AuthRepositoryRef ref) async {
  final dataSource = await ref.read(authLocalDataSourceProvider.future);
  return AuthRepositoryImpl(dataSource);
}

@riverpod
@visibleForTesting
Future<AuthLocalDataSource> authLocalDataSource(AuthLocalDataSourceRef ref) async {
  final localStorage = await ref.read(localStorageProvider.future);
  return AuthLocalDataSourceImpl(localStorage);
}
