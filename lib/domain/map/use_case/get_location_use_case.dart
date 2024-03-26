import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/map/location.dart';
import 'package:tripper/domain/map/map_providers.dart';

part 'get_location_use_case.g.dart';

@riverpod
Future<Position?> getLocationUseCase(GetLocationUseCaseRef ref) => _getCurrentLocation();

@riverpod
Stream<Position?> getLocationStreamUseCase(GetLocationStreamUseCaseRef ref) async* {
  final streamController = StreamController<Position?>();

  try {
    final lastKnownLocation = (await ref.read(mapRepositoryProvider.future)).getPosition();
    streamController.add(lastKnownLocation.asGeolocatorPosition);
  } catch (_) {}

  unawaited(_getCurrentLocationStream(streamController));

  yield* streamController.stream;
}

Future<Position?> _getCurrentLocation() async {
  log('Getting current location in location provider');
  final hasGivenPermission = await _getLocationPermissions();
  if (!hasGivenPermission) return null;

  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

Future<void> _getCurrentLocationStream(StreamController<Position?> streamController) async {
  final hasGivenPermission = await _getLocationPermissions();
  if (!hasGivenPermission) streamController.addError('Location service unavailable');

  final lastKnownPosition = await Geolocator.getLastKnownPosition();
  streamController.add(lastKnownPosition);

  final currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  streamController.add(currentPosition);
}

Future<bool> _getLocationPermissions() async {
  // Test if location services are enabled.
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw const LocationServiceDisabledException();
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) return false;
  }

  if (permission == LocationPermission.deniedForever) return false;

  if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) return true;

  return false;
}

extension on Location {
  Position get asGeolocatorPosition => Position(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now(),
        speed: 0,
        heading: 0,
        altitude: 0,
        accuracy: 100,
        speedAccuracy: 100,
        headingAccuracy: 100,
        altitudeAccuracy: 100,
      );
}
