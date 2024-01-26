import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/map/map_providers.dart';
import 'package:tripper/domain/map/location.dart';

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

  unawaited(_determinePosition(streamController));

  yield* streamController.stream;
}

Future<Position?> _getCurrentLocation() async {
  log('Getting current location in location provider');
  // Test if location services are enabled.
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return null;

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return null;
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) return null;
  }

  final location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  return location;
}

Future<void> _determinePosition(StreamController<Position?> streamController) async {
  // Test if location services are enabled.
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    streamController.addError('Location services are disabled.');
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      streamController.addError('Location permissions are denied');
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    streamController.addError('Location permissions are permanently denied, we cannot request permissions.');
    return;
  }

  final initialPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  streamController.add(initialPosition);
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
