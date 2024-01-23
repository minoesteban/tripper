import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/auth/auth_providers.dart';

part 'is_signed_in_use_case.g.dart';

@riverpod
Future<bool> isSignedInUseCase(IsSignedInUseCaseRef ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return await ref.read(authRepositoryProvider).isSignedInStream.first;
}

@Riverpod(keepAlive: true)
Stream<bool> isSignedInStream(IsSignedInStreamRef ref) {
  return ref.watch(authRepositoryProvider).isSignedInStream;
}
