import 'package:flutter/foundation.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/core/storage/core_providers.dart';
import 'package:tripper/data/map/map_local_data_source.dart';
import 'package:tripper/data/map/map_local_data_source_impl.dart';
import 'package:tripper/data/map/map_remote_data_source.dart';
import 'package:tripper/data/map/map_remote_data_source_impl.dart';
import 'package:tripper/domain/map/repository/map_repository.dart';
import 'package:tripper/domain/map/repository/map_repository_impl.dart';
import 'package:tripper/utils/platform.dart';

part 'map_providers.g.dart';

@riverpod
Future<MapRepository> mapRepository(MapRepositoryRef ref) async {
  final localDataSource = await ref.read(mapLocalDataSourceProvider.future);
  final remoteDataSource = await ref.read(mapRemoteDataSourceProvider.future);
  return MapRepositoryImpl(localDataSource: localDataSource, remoteDataSource: remoteDataSource);
}

@riverpod
@visibleForTesting
Future<MapLocalDataSource> mapLocalDataSource(MapLocalDataSourceRef ref) async {
  final localStorage = await ref.read(localStorageProvider.future);
  return MapLocalDataSourceImpl(localStorage);
}

@riverpod
@visibleForTesting
Future<MapRemoteDataSource> mapRemoteDataSource(MapRemoteDataSourceRef ref) async {
  final placesClient = await ref.read(placesClientInstanceProvider.future);
  return MapRemoteDataSourceImpl(placesClient);
}

@riverpod
@visibleForTesting
Future<GoogleMapsPlaces> placesClientInstance(PlacesClientInstanceRef ref) async {
  final mapsAPIKey = ref.read(mapsAPIKeyProvider);
  final packageInfo = await ref.read(packageInfoProvider.future);

  return GoogleMapsPlaces(
    apiKey: mapsAPIKey,
    apiHeaders: {
      if (isIOS) 'X-Ios-Bundle-Identifier': packageInfo.packageName,
      if (isAndroid) 'X-Android-Package': packageInfo.packageName,
      if (isAndroid) 'X-Android-Cert': packageInfo.buildSignature,
    },
  );
}
