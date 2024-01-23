import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_storage.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences localStorage(LocalStorageRef ref) {
  throw UnimplementedError();
}
// class LocalStorage extends _$LocalStorage {
//   late SharedPreferences _sharedPreferences;

//   @override
//   Future<void> build() async {
//     _sharedPreferences = await SharedPreferences.getInstance();
//   }

//   String? getString(String key) => _sharedPreferences.getString(key);

//   Future<bool> setString(String key, String value) => _sharedPreferences.setString(key, value);

//   Future<bool> remove(String key) => _sharedPreferences.remove(key);
// }
