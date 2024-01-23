import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.init() = _SignInStateInit;

  const factory SignInState.signedIn() = _SignInStateSignedIn;

  const factory SignInState.signedOut() = _SignInStateSignedOut;
}
