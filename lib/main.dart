import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripper/core/storage/local_storage.dart';
import 'package:tripper/l10n/l10n_utils.dart';
import 'package:tripper/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  await L10n.load(L10n.delegate.supportedLocales.first);

  Gemini.init(
    apiKey: _getGeminiAPIKey(),
    enableDebugging: true,
  );

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
          seedColor: Colors.blue.shade800,
          brightness: Brightness.dark,
        ),
      ),
      routerConfig: router,
    );
  }
}

String _getGeminiAPIKey() {
  if (kIsWeb) {
    return FlutterConfig.get('GEMINI_API_KEY_WEB') as String;
  }

  if (defaultTargetPlatform == TargetPlatform.android) {
    return FlutterConfig.get('GEMINI_API_KEY_ANDROID') as String;
  }

  return FlutterConfig.get('GEMINI_API_KEY_IOS') as String;
}
