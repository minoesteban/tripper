import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/screens/utils/exports.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Text(context.l10n.appName),
          const SizedBox(height: Dimensions.xxxl),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
