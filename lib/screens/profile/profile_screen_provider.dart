import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/auth/sign_out_use_case.dart';
import 'package:tripper/screens/profile/profile_state.dart';

part 'profile_screen_provider.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<ProfileState> build() async {
    state = const AsyncValue.loading();

    return const ProfileState.idle();
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    ref.read(signOutUseCaseProvider);

    return;
  }
}
