import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/core/storage/local_storage.dart';
import 'package:tripper/data/map/map_local_data_source.dart';
import 'package:tripper/data/map/map_local_data_source_impl.dart';
import 'package:tripper/data/map/map_repository.dart';
import 'package:tripper/data/map/map_repository_impl.dart';

part 'map_providers.g.dart';

@riverpod
MapRepository mapRepository(MapRepositoryRef ref) {
  final dataSource = ref.read(mapLocalDataSourceProvider);
  final repository = MapRepositoryImpl(dataSource);

  return repository;
}

@riverpod
@visibleForTesting
MapLocalDataSource mapLocalDataSource(MapLocalDataSourceRef ref) {
  final localStorage = ref.read(localStorageProvider);
  return MapLocalDataSourceImpl(localStorage);
}
