import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.init({@Default(LatLng(0, 0)) LatLng currentPosition}) = _MapStateInit;

  const factory MapState.idle({required LatLng currentPosition}) = _MapStateIdle;
}
