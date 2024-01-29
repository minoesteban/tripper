import 'package:tripper/data/map/dto/location_dto.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

class PlaceSearchResultDTO {
  const PlaceSearchResultDTO({
    required this.placeId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.location,
    required this.type,
    this.address,
  });

  final String placeId;
  final String name;
  final String description;
  final String? imageUrl;
  final double? rating;
  final LocationDTO location;
  final PointOfInterestType type;
  final String? address;
}
