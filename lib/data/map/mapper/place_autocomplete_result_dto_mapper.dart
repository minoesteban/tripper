import 'package:tripper/data/map/dto/place_autocomplete_result_dto.dart';
import 'package:tripper/data/utils/bidirectional_mapper.dart';
import 'package:tripper/domain/map/place_autocomplete_result.dart';

class PlaceAutocompleteResultDTOMapper
    implements BidirectionalMapper<PlaceAutocompleteResultDTO, PlaceAutocompleteResult> {
  const PlaceAutocompleteResultDTOMapper();

  @override
  PlaceAutocompleteResult to(PlaceAutocompleteResultDTO data) {
    return PlaceAutocompleteResult(
      placeId: data.placeId,
      description: data.description,
    );
  }

  @override
  PlaceAutocompleteResultDTO from(PlaceAutocompleteResult data) {
    return PlaceAutocompleteResultDTO(
      placeId: data.placeId,
      description: data.description,
    );
  }
}
