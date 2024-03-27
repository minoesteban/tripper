import 'package:tripper/data/map/dto/place_autocomplete_result_dto.dart';
import 'package:tripper/data/utils/bidirectional_mapper.dart';
import 'package:tripper/domain/map/search_destination_result.dart';

class PlaceAutocompleteResultDTOMapper
    implements BidirectionalMapper<PlaceAutocompleteResultDTO, SearchDestinationResult> {
  const PlaceAutocompleteResultDTOMapper();

  @override
  SearchDestinationResult to(PlaceAutocompleteResultDTO data) {
    return SearchDestinationResult(
      placeId: data.placeId,
      description: data.description,
    );
  }

  @override
  PlaceAutocompleteResultDTO from(SearchDestinationResult data) {
    return PlaceAutocompleteResultDTO(
      placeId: data.placeId,
      description: data.description,
    );
  }
}
