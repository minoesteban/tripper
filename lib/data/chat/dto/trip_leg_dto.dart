import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_leg_dto.g.dart';

@JsonSerializable()
class TripLegDTO {
  const TripLegDTO({
    required this.title,
    required this.imageUrl,
    required this.fromDate,
    required this.toDate,
    required this.places,
    required this.activities,
  });

  factory TripLegDTO.fromJson(Map<String, dynamic> json) => _$TripLegDTOFromJson(json);

  final String title;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'from_date')
  final DateTime fromDate;
  @JsonKey(name: 'to_date')
  final DateTime toDate;
  final List<String> places;
  final List<String> activities;
}
