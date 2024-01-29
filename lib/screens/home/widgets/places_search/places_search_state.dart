import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

part 'places_search_state.freezed.dart';

@freezed
class PlacesSearchState with _$PlacesSearchState {
  const factory PlacesSearchState.init() = _PlacesSearchStateInit;

  const factory PlacesSearchState.idle(
    List<PointOfInterest> results,
  ) = _PlacesSearchStateIdle;

  const factory PlacesSearchState.selected(
    PointOfInterest place,
  ) = _PlacesSearchStateSelected;
}
