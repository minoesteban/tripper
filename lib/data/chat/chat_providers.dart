import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/chat/chat_data_source.dart';
import 'package:tripper/data/chat/chat_remote_data_source.dart';
import 'package:tripper/data/chat/chat_repository.dart';
import 'package:tripper/data/chat/chat_repository_impl.dart';

part 'chat_providers.g.dart';

@riverpod
ChatRepository chatRepository(ChatRepositoryRef ref) {
  final dataSource = ref.read(chatDataSourceProvider);
  final repository = ChatRepositoryImpl(dataSource);

  return repository;
}

@riverpod
@visibleForTesting
ChatDataSource chatDataSource(ChatDataSourceRef ref) {
  return ChatRemoteDataSource();
}
