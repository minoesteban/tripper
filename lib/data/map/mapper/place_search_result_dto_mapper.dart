import 'package:tripper/data/map/dto/place_search_result_dto.dart';
import 'package:tripper/data/map/mapper/location_dto_mapper.dart';
import 'package:tripper/data/utils/bidirectional_mapper.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

class PlaceSearchResultDTOMapper implements BidirectionalMapper<PlaceSearchResultDTO, PointOfInterest> {
  const PlaceSearchResultDTOMapper();

  LocationDTOMapper get locationDTOMapper => const LocationDTOMapper();

  @override
  PointOfInterest to(PlaceSearchResultDTO data) {
    return PointOfInterest(
      placeId: data.placeId,
      name: data.name,
      description: data.description,
      imageUrl: data.imageUrl,
      rating: data.rating,
      location: locationDTOMapper.to(data.location),
      type: data.type,
    );
  }

  @override
  PlaceSearchResultDTO from(PointOfInterest data) {
    return PlaceSearchResultDTO(
      placeId: data.placeId,
      name: data.name,
      description: data.description,
      imageUrl: data.imageUrl,
      rating: data.rating,
      location: locationDTOMapper.from(data.location),
      type: data.type,
    );
  }
}
