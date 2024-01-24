import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tripper/screens/map/map_screen_provider.dart';

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  static const routeName = '/map';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPositionNotifier = useValueNotifier<LatLng>(const LatLng(0, 0));

    late GoogleMapController mapController;

    ref.listen(mapNotifierProvider, (_, state) {
      state.mapOrNull(data: (data) {
        if (data.value.currentPosition != currentPositionNotifier.value) {
          currentPositionNotifier.value = data.value.currentPosition;
          mapController.animateCamera(
            CameraUpdate.newLatLng(currentPositionNotifier.value),
          );
        }
      });
    });

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: currentPositionNotifier,
        builder: (context, position, _) {
          return GoogleMap(
            myLocationEnabled: true,
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: position,
              zoom: 14.0,
            ),
          );
        },
      ),
    );
  }
}
