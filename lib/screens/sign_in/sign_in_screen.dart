import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripper/l10n/l10n_utils.dart';
import 'package:tripper/screens/sign_in/sign_in_provider.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInNotifierProvider);

    return state.map(
      data: (data) => data.value.maybeWhen(
        idle: (isSignedIn) => isSignedIn
            ? Center(
                child: Text(context.l10n.signIn_signedIn),
              )
            : ElevatedButton(
                onPressed: ref.read(signInNotifierProvider.notifier).signIn,
                child: Text(context.l10n.signIn_signIn_action),
              ),
        orElse: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error) => Center(
        child: Text(error.error.toString()),
      ),
      loading: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
