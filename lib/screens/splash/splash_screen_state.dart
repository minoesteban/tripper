import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_state.freezed.dart';

@freezed
class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState.init() = _SplashScreenStateInit;

  const factory SplashScreenState.signedIn() = _SplashScreenStateSignedIn;

  const factory SplashScreenState.signedOut() = _SplashScreenStateSignedOut;
}
