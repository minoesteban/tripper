import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripper/l10n/l10n_utils.dart';
import 'package:tripper/router.dart';
import 'package:tripper/screens/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  await L10n.load(L10n.delegate.supportedLocales.first);

  runApp(
    const ProviderScope(
      child: TripperApp(),
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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: TripperTheme.dark,
      routerConfig: router,
    );
  }
}
