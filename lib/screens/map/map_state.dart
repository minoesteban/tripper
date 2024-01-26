import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/domain/map/location.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState.init({
    @Default(Location(latitude: 0, longitude: 0)) Location currentPosition,
    @Default([]) List<PointOfInterest> pointsOfInterest,
  }) = _MapStateInit;

  const factory MapState.idle({
    required Location currentPosition,
    @Default([]) List<PointOfInterest> pointsOfInterest,
  }) = _MapStateIdle;
}
