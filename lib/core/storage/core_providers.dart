import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'core_providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> localStorage(LocalStorageRef ref) async {
  return await SharedPreferences.getInstance();
}

@riverpod
Future<PackageInfo> packageInfo(PackageInfoRef ref) async {
  return await PackageInfo.fromPlatform();
}

@riverpod
String geminiAPIKey(GeminiAPIKeyRef ref) {
  if (kIsWeb) {
    return FlutterConfig.get('GEMINI_API_KEY_WEB') as String;
  }

  if (defaultTargetPlatform == TargetPlatform.android) {
    return FlutterConfig.get('GEMINI_API_KEY_ANDROID') as String;
  }

  return FlutterConfig.get('GEMINI_API_KEY_IOS') as String;
}

@riverpod
String mapsAPIKey(MapsAPIKeyRef ref) {
  if (kIsWeb) {
    return FlutterConfig.get('GOOGLE_MAPS_API_KEY_WEB') as String;
  }

  if (defaultTargetPlatform == TargetPlatform.android) {
    return FlutterConfig.get('GOOGLE_MAPS_API_KEY_ANDROID') as String;
  }

  return FlutterConfig.get('GOOGLE_MAPS_API_KEY_IOS') as String;
}
