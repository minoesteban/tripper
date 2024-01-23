import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/screens/utils/exports.dart';

class TripsScreen extends HookConsumerWidget {
  const TripsScreen({super.key});

  static const routeName = '/trips';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.l10n.trips_title),
          ],
        ),
      ),
    );
  }
}
