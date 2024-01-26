import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/core/storage/core_providers.dart';
import 'package:tripper/data/map/map_local_data_source.dart';
import 'package:tripper/data/map/map_local_data_source_impl.dart';
import 'package:tripper/data/map/map_repository.dart';
import 'package:tripper/data/map/map_repository_impl.dart';

part 'map_providers.g.dart';

@riverpod
Future<MapRepository> mapRepository(MapRepositoryRef ref) async {
  final dataSource = await ref.read(mapLocalDataSourceProvider.future);
  return MapRepositoryImpl(dataSource);
}

@riverpod
@visibleForTesting
Future<MapLocalDataSource> mapLocalDataSource(MapLocalDataSourceRef ref) async {
  final localStorage = await ref.read(localStorageProvider.future);
  return MapLocalDataSourceImpl(localStorage);
}
