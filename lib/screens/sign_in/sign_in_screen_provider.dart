import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/auth/use_case/sign_in_use_case.dart';
import 'package:tripper/screens/sign_in/sign_in_state.dart';

part 'sign_in_screen_provider.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  Future<SignInState> build() async {
    state = const AsyncValue.loading();

    return const SignInState.signedOut();
  }

  Future<void> signIn() async {
    state = const AsyncValue.loading();
    ref.read(signInUseCaseProvider);

    return;
  }
}
