import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/auth/auth_providers.dart';

part 'sign_out_use_case.g.dart';

@riverpod
Future<void> signOutUseCase(SignOutUseCaseRef ref) async {
  await Future.delayed(const Duration(seconds: 1));
  await (await ref.read(authRepositoryProvider.future)).deleteToken();
}
