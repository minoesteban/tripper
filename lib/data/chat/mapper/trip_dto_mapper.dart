import 'package:tripper/data/chat/dto/trip_dto.dart';
import 'package:tripper/data/chat/mapper/trip_leg_dto_mapper.dart';
import 'package:tripper/data/utils/bidirectional_mapper.dart';
import 'package:tripper/domain/chat/trip.dart';

class TripDTOMapper implements BidirectionalMapper<TripDTO, Trip> {
  const TripDTOMapper();

  TripLegDTOMapper get tripLegDTOMapper => const TripLegDTOMapper();

  @override
  Trip to(TripDTO data) {
    return Trip(
      name: data.name,
      imageUrl: data.imageUrl,
      legs: data.legs.map(tripLegDTOMapper.to).toList(),
    );
  }

  @override
  TripDTO from(Trip data) {
    return TripDTO(
      name: data.name,
      imageUrl: data.imageUrl,
      legs: data.legs.map(tripLegDTOMapper.from).toList(),
    );
  }
}
