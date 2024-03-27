import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/domain/map/search_destination_result.dart';

part 'places_search_state.freezed.dart';

@freezed
class PlacesSearchState with _$PlacesSearchState {
  const factory PlacesSearchState.init() = _PlacesSearchStateInit;

  const factory PlacesSearchState.idle(
    List<SearchDestinationResult> results,
  ) = _PlacesSearchStateIdle;

  const factory PlacesSearchState.selected(
    SearchDestinationResult place,
  ) = _PlacesSearchStateSelected;
}
