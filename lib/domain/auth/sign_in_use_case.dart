import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/auth/auth_providers.dart';

part 'sign_in_use_case.g.dart';

@riverpod
Future<void> signInUseCase(SignInUseCaseRef ref) async {
  await Future.delayed(const Duration(seconds: 1));
  await ref.read(authRepositoryProvider).saveToken('token');
}
