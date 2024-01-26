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
