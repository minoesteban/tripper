import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  static const routeName = '/map';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
        ),
      ),
    );
  }
}
