import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/data/chat/dto/trip_leg_dto.dart';

part 'trip_dto.g.dart';

@JsonSerializable()
class TripDTO {
  const TripDTO({
    required this.name,
    required this.imageUrl,
    required this.legs,
  });

  factory TripDTO.fromJson(Map<String, dynamic> json) => _$TripDTOFromJson(json);

  final String name;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final List<TripLegDTO> legs;
}
