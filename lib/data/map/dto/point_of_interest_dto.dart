import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/data/map/dto/location_dto.dart';

part 'point_of_interest_dto.g.dart';

@JsonSerializable()
class PointOfInterestDTO {
  PointOfInterestDTO({
    required this.placeId,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.location,
  });

  factory PointOfInterestDTO.fromJson(Map<String, dynamic> json) => _$PointOfInterestDTOFromJson(json);

  @JsonKey(name: 'place_id')
  final String placeId;
  final String name;
  final String description;
  @JsonKey(name: 'image_url')
  final String image;
  final double rating;
  final LocationDTO location;
}
