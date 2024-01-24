import 'dart:async';
import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/map/get_location_use_case.dart';
import 'package:tripper/screens/map/map_state.dart';

part 'map_screen_provider.g.dart';

@riverpod
class MapNotifier extends _$MapNotifier {
  @override
  Future<MapState> build() async {
    state = const AsyncValue.loading();

    ref.listen(getLocationUseCaseProvider, (_, next) {
      final positionData = next;

      if (positionData.hasError) {
        log('${positionData.error}');
        return;
      }

      if (positionData.hasValue && positionData.value != null) {
        final position = positionData.value!;
        log('Location obtained $position');
        state = AsyncValue.data(
          MapState.idle(
            currentPosition: LatLng(position.latitude, position.longitude),
          ),
        );
      }
    });

    return const MapState.init();
  }
}
