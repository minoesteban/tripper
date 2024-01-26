import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/core/storage/core_providers.dart';
import 'package:tripper/data/chat/chat_data_source.dart';
import 'package:tripper/data/chat/chat_remote_data_source.dart';
import 'package:tripper/data/chat/chat_repository.dart';
import 'package:tripper/data/chat/chat_repository_impl.dart';

part 'chat_providers.g.dart';

@riverpod
Future<ChatRepository> chatRepository(ChatRepositoryRef ref) async {
  final dataSource = await ref.read(chatDataSourceProvider.future);
  return ChatRepositoryImpl(dataSource);
}

@riverpod
@visibleForTesting
Future<ChatDataSource> chatDataSource(ChatDataSourceRef ref) async {
  final packageInfo = await ref.read(packageInfoProvider.future);
  return ChatRemoteDataSource(packageInfo);
}
