import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/map/location.dart';
import 'package:tripper/domain/map/use_case/get_location_use_case.dart';
import 'package:tripper/domain/map/use_case/get_nearby_landmarks_use_case.dart';
import 'package:tripper/domain/map/use_case/get_nearby_restaurants_use_case.dart';
import 'package:tripper/screens/map/map_state.dart';
import 'package:tripper/utils/debouncer.dart';

part 'map_screen_provider.g.dart';

const _nearbyPlacesFetchDebounceTime = Duration(milliseconds: 1500);

@riverpod
class MapNotifier extends _$MapNotifier {
  final _debouncer = Debouncer(_nearbyPlacesFetchDebounceTime);

  @override
  Future<MapState> build() async => const MapState.init();

  void listenToCurrentLocation() {
    ref.listen(getLocationStreamUseCaseProvider, (_, next) {
      next.whenData((position) async {
        if (position == null) return;

        final location = Location(
          latitude: position.latitude,
          longitude: position.longitude,
        );

        state = AsyncValue.data(
          MapState.idle(currentLocation: location),
        );

        _debouncer.run(() async {
          await getNearbyLandmarks(location);

          await getNearbyRestaurants(location);
        });
      });
    });
  }

  Future<void> getCurrentLocation() async {
    final position = await ref.watch(getLocationUseCaseProvider.future);

    if (position == null) return;

    final location = Location(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    state = AsyncValue.data(
      MapState.idle(currentLocation: location),
    );

    await getNearbyLandmarks(location);

    await getNearbyRestaurants(location);
  }

  Future<void> getNearbyLandmarks(Location location) async {
    final landmarks = await ref.watch(
      getNearbyLandmarksUseCaseProvider(location.latitude, location.longitude).future,
    );

    state = AsyncValue.data(
      MapState.idle(
        currentLocation: location,
        landmarks: landmarks,
      ),
    );
  }

  Future<void> getNearbyRestaurants(Location location) async {
    final restaurants = await ref.watch(
      getNearbyRestaurantsUseCaseProvider(location.latitude, location.longitude).future,
    );

    final currentState = state.requireValue;

    state = AsyncValue.data(
      MapState.idle(
        currentLocation: location,
        landmarks: currentState.map(init: (_) => [], idle: (s) => s.landmarks),
        restaurants: restaurants,
      ),
    );
  }
}
