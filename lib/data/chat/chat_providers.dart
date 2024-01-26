import 'package:flutter/foundation.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/core/storage/core_providers.dart';
import 'package:tripper/data/chat/chat_remote_data_source.dart';
import 'package:tripper/data/chat/chat_remote_data_source_impl.dart';
import 'package:tripper/data/chat/chat_repository.dart';
import 'package:tripper/data/chat/chat_repository_impl.dart';
import 'package:tripper/utils/platform.dart';

part 'chat_providers.g.dart';

@riverpod
Future<ChatRepository> chatRepository(ChatRepositoryRef ref) async {
  final dataSource = await ref.read(chatDataSourceProvider.future);
  return ChatRepositoryImpl(dataSource);
}

@riverpod
@visibleForTesting
Future<ChatRemoteDataSource> chatDataSource(ChatDataSourceRef ref) async {
  final gemini = await ref.read(geminiInstanceProvider.future);
  return ChatRemoteDataSourceImpl(gemini);
}

@riverpod
@visibleForTesting
Future<Gemini> geminiInstance(GeminiInstanceRef ref) async {
  final geminiAPIKey = ref.read(geminiAPIKeyProvider);
  final packageInfo = await ref.read(packageInfoProvider.future);

  Gemini.init(
    enableDebugging: true,
    apiKey: geminiAPIKey,
    headers: {
      if (isIOS) 'X-Ios-Bundle-Identifier': packageInfo.packageName,
      if (isAndroid) 'X-Android-Package': packageInfo.packageName,
      if (isAndroid) 'X-Android-Cert': packageInfo.buildSignature,
    },
  );

  return Gemini.instance;
}
