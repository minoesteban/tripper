import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/domain/map/place_autocomplete_result.dart';

part 'places_search_state.freezed.dart';

@freezed
class PlacesSearchState with _$PlacesSearchState {
  const factory PlacesSearchState.init() = _PlacesSearchStateInit;

  const factory PlacesSearchState.idle(
    List<PlaceAutocompleteResult> results,
  ) = _PlacesSearchStateIdle;

  const factory PlacesSearchState.selected(
    PlaceAutocompleteResult place,
  ) = _PlacesSearchStateSelected;
}
