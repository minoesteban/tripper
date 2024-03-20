import 'package:tripper/data/chat/dto/trip_leg_dto.dart';
import 'package:tripper/data/utils/bidirectional_mapper.dart';
import 'package:tripper/domain/chat/trip_leg.dart';

class TripLegDTOMapper implements BidirectionalMapper<TripLegDTO, TripLeg> {
  const TripLegDTOMapper();

  @override
  TripLeg to(TripLegDTO data) {
    return TripLeg(
      title: data.title,
      imageUrl: data.imageUrl,
      fromDate: data.fromDate,
      toDate: data.toDate,
      places: data.places,
      activities: data.activities,
    );
  }

  @override
  TripLegDTO from(TripLeg data) {
    return TripLegDTO(
      title: data.title,
      imageUrl: data.imageUrl,
      fromDate: data.fromDate,
      toDate: data.toDate,
      places: data.places,
      activities: data.activities,
    );
  }
}
