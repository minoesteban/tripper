import 'package:tripper/data/map/dto/location_dto.dart';
import 'package:tripper/data/utils/bidirectional_mapper.dart';
import 'package:tripper/domain/map/location.dart';

class LocationDTOMapper implements BidirectionalMapper<LocationDTO, Location> {
  const LocationDTOMapper();

  @override
  Location to(LocationDTO data) {
    return Location(
      latitude: data.latitude,
      longitude: data.longitude,
    );
  }

  @override
  LocationDTO from(Location data) {
    return LocationDTO(
      latitude: data.latitude,
      longitude: data.longitude,
    );
  }
}
