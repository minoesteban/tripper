import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/screens/sign_in/sign_in_state.dart';

part 'sign_in_provider.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  Future<SignInState> build() async => const SignInState.init();

  void signIn() async => const SignInState.idle(isSignedIn: true);
}
