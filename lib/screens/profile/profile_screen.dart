import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/screens/profile/profile_screen_provider.dart';
import 'package:tripper/screens/utils/exports.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.l10n.profile_title),
            const SizedBox(height: Dimensions.xxxl),
            state.map(
              data: (_) => ElevatedButton.icon(
                onPressed: ref.read(profileNotifierProvider.notifier).signOut,
                icon: const Icon(Icons.logout_rounded),
                label: Text(context.l10n.profile_signOut_action),
              ),
              error: (error) => Center(
                child: Text(
                  error.error.toString(),
                ),
              ),
              loading: (_) => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
