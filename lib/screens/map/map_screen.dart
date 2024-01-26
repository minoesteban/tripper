import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/domain/map/location.dart';
import 'package:tripper/screens/map/map_screen_provider.dart';

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  static const routeName = '/map';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPositionNotifier = useValueNotifier<Location?>(null);
    final markers = useValueNotifier(<Marker>{});

    late GoogleMapController mapController;

    void onMapCreated(GoogleMapController controller) {
      mapController = controller;
      ref.read(mapNotifierProvider.notifier).getCurrentLocation();
    }

    ref.listen(mapNotifierProvider, (_, state) {
      state.when(
        loading: () => log('MapScreen: loading'),
        error: (error, stackTrace) => log('MapScreen: error: $error'),
        data: (data) => data.when(
          init: (_, __) => log('MapScreen: init'),
          idle: (currentPosition, pointsOfInterest) {
            log('MapScreen: idle: $currentPosition, ${pointsOfInterest.length}');

            if (currentPosition != currentPositionNotifier.value) {
              currentPositionNotifier.value = currentPosition;
              mapController.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(currentPosition.latitude, currentPosition.longitude),
                ),
              );
            }

            if (pointsOfInterest.isNotEmpty) {
              markers.value.clear();
              markers.value.addAll(
                pointsOfInterest.map(
                  (e) => Marker(
                    markerId: MarkerId(e.placeId),
                    position: LatLng(e.location.latitude, e.location.longitude),
                    infoWindow: InfoWindow(
                      title: e.name,
                      snippet: e.description,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );
    });

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: currentPositionNotifier,
        builder: (_, position, ___) => GoogleMap(
          markers: markers.value,
          myLocationEnabled: true,
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
            zoom: 14.0,
          ),
        ),
      ),
    );
  }
}
