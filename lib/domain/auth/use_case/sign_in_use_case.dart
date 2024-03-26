import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/auth/auth_providers.dart';

part 'sign_in_use_case.g.dart';

@riverpod
Future<void> signInUseCase(SignInUseCaseRef ref) async {
  final authRepository = await ref.read(authRepositoryProvider.future);

  await Future.delayed(const Duration(seconds: 1));
  await authRepository.saveToken('token');
}
