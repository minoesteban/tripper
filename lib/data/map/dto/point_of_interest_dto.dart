import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/data/map/dto/location_dto.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

part 'point_of_interest_dto.g.dart';

@JsonSerializable()
class PointOfInterestDTO {
  PointOfInterestDTO({
    required this.placeId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.location,
    required this.type,
  });

  factory PointOfInterestDTO.fromJson(Map<String, dynamic> json) => _$PointOfInterestDTOFromJson(json);

  @JsonKey(name: 'place_id')
  final String placeId;
  final String name;
  final String description;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final double? rating;
  final LocationDTO location;
  final PointOfInterestType type;
}
