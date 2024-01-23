import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/screens/splash/splash_screen_state.dart';

part 'splash_screen_provider.g.dart';

@riverpod
class SplashScreenNotifier extends _$SplashScreenNotifier {
  @override
  Future<SplashScreenState> build() async {
    state = const AsyncValue.loading();

    return const SplashScreenState.init();
  }
}
