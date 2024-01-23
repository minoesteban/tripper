import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripper/screens/sign_in/sign_in_screen_provider.dart';
import 'package:tripper/screens/utils/exports.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInNotifierProvider);

    return Scaffold(
      body: state.map(
        data: (data) => data.value.maybeMap(
          signedIn: (value) => Center(
            child: Text(context.l10n.signIn_signedIn),
          ),
          signedOut: (data) => Center(
            child: ElevatedButton(
              onPressed: ref.read(signInNotifierProvider.notifier).signIn,
              child: Text(context.l10n.signIn_signIn_action),
            ),
          ),
          orElse: SizedBox.shrink,
        ),
        error: (error) => Center(
          child: Text(
            error.error.toString(),
          ),
        ),
        loading: (_) => const Center(
          child: _Loading(),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.l10n.signIn_title),
        const SizedBox(height: Dimensions.xxxl),
        const CircularProgressIndicator(),
      ],
    );
  }
}
