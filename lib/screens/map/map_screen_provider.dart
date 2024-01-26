import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/chat/use_case/get_points_of_interest_use_case.dart';
import 'package:tripper/domain/map/location.dart';
import 'package:tripper/domain/map/use_case/get_location_use_case.dart';
import 'package:tripper/screens/map/map_state.dart';

part 'map_screen_provider.g.dart';

@riverpod
class MapNotifier extends _$MapNotifier {
  @override
  Future<MapState> build() async => const MapState.init();

  Future<void> getCurrentLocation() async {
    final position = await ref.watch(getLocationUseCaseProvider.future);

    if (position == null) return;

    state = AsyncValue.data(
      MapState.idle(
        currentPosition: Location(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      ),
    );

    await getPointsOfInterest(
      Location(latitude: position.latitude, longitude: position.longitude),
    );
  }

  Future<void> getPointsOfInterest(Location location) async {
    final pointsOfInterest = await ref.watch(
      getPointsOfInterestUseCaseProvider(location.latitude, location.longitude).future,
    );

    state = AsyncValue.data(
      MapState.idle(
        currentPosition: location,
        pointsOfInterest: pointsOfInterest,
      ),
    );
  }
}
