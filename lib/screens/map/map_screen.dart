import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/domain/map/location.dart';
import 'package:tripper/domain/map/point_of_interest.dart';
import 'package:tripper/screens/map/map_screen_provider.dart';
import 'package:tripper/screens/utils/listenable_builders.dart';

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  static const routeName = '/map';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocationNotifier = useValueNotifier<Location?>(null);
    final markersNotifier = useValueNotifier(<Marker>{});

    late GoogleMapController mapController;

    void onMapCreated(GoogleMapController controller) {
      mapController = controller;
      ref.read(mapNotifierProvider.notifier).listenToCurrentLocation();
    }

    ref.listen(mapNotifierProvider, (_, state) {
      state.whenOrNull(
        data: (data) => data.whenOrNull(
          idle: (currentLocation, landmarks, restaurants) {
            // If current location changed, move camera to new location
            if (currentLocation != currentLocationNotifier.value) {
              currentLocationNotifier.value = currentLocation;
              mapController.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(currentLocation.latitude, currentLocation.longitude),
                ),
              );
            }

            final newMarkers = <Marker>{};
            if (landmarks.isNotEmpty) {
              newMarkers.addAll(landmarks.map(pointOfInterestasMarker));
            }

            if (restaurants.isNotEmpty) {
              newMarkers.addAll(restaurants.map(pointOfInterestasMarker));
            }

            if (markersNotifier.value != newMarkers) {
              markersNotifier.value = newMarkers;
            }
          },
        ),
      );
    });

    return Scaffold(
      body: ValueListenableBuilder2<Location?, Set<Marker>>(
        notifier1: currentLocationNotifier,
        notifier2: markersNotifier,
        builder: (context, position, markers, _) => GoogleMap(
          markers: markers,
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

Marker pointOfInterestasMarker(PointOfInterest point) => Marker(
      markerId: MarkerId(point.placeId),
      icon: point.type.asBitmapDescriptor,
      position: LatLng(point.location.latitude, point.location.longitude),
      infoWindow: InfoWindow(
        title: point.name,
        snippet: point.description,
      ),
    );

extension on PointOfInterestType {
  BitmapDescriptor get asBitmapDescriptor {
    switch (this) {
      case PointOfInterestType.destination:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case PointOfInterestType.landmark:
        return BitmapDescriptor.defaultMarker;
      case PointOfInterestType.restaurant:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    }
  }
}
