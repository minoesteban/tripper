import 'package:tripper/data/map/dto/point_of_interest_dto.dart';
import 'package:tripper/data/map/mapper/location_dto_mapper.dart';
import 'package:tripper/data/utils/bidirectional_mapper.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

class PointOfInterestDTOMapper implements BidirectionalMapper<PointOfInterestDTO, PointOfInterest> {
  const PointOfInterestDTOMapper();

  LocationDTOMapper get locationDTOMapper => const LocationDTOMapper();

  @override
  PointOfInterestDTO from(PointOfInterest data) {
    return PointOfInterestDTO(
      placeId: data.placeId,
      name: data.name,
      description: data.description,
      image: data.image,
      rating: data.rating,
      location: locationDTOMapper.from(data.location),
    );
  }

  @override
  PointOfInterest to(PointOfInterestDTO data) {
    return PointOfInterest(
      placeId: data.placeId,
      name: data.name,
      description: data.description,
      image: data.image,
      rating: data.rating,
      location: locationDTOMapper.to(data.location),
    );
  }
}
