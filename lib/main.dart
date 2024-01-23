import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripper/core/storage/local_storage.dart';
import 'package:tripper/l10n/l10n_utils.dart';
import 'package:tripper/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await L10n.load(const Locale('en'));

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        localStorageProvider.overrideWithValue(sharedPreferences),
      ],
      child: const TripperApp(),
    ),
  );
}

class TripperApp extends ConsumerWidget {
  const TripperApp({
    this.initialPath,
    super.key,
  });

  final String? initialPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider(initialPath));

    return MaterialApp.router(
      title: L10n.current.appName,
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red.shade800,
          brightness: Brightness.dark,
        ),
      ),
      routerConfig: router,
    );
  }
}
