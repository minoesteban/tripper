import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/map/map_providers.dart';
import 'package:tripper/domain/map/location.dart';

part 'get_location_use_case.g.dart';

@riverpod
Stream<Position?> getLocationUseCase(GetLocationUseCaseRef ref) {
  final streamController = StreamController<Position?>();

  try {
    final lastKnownPosition = ref.read(mapRepositoryProvider).getPosition();
    streamController.add(lastKnownPosition.asGeolocatorPosition);
  } catch (_) {}

  _determinePosition(streamController);

  return streamController.stream;
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

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  // const LocationSettings locationSettings = LocationSettings(
  //   accuracy: LocationAccuracy.high,
  //   distanceFilter: 100,
  // );

  // Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
  //   streamController.add(position);
  // });

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
