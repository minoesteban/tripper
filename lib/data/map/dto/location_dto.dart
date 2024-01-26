import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDTO {
  const LocationDTO({
    required this.latitude,
    required this.longitude,
  });

  factory LocationDTO.fromJson(Map<String, dynamic> json) => _$LocationDTOFromJson(json);

  final double latitude;
  final double longitude;
}
