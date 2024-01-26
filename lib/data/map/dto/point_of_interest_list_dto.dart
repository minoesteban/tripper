import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/data/map/dto/point_of_interest_dto.dart';

part 'point_of_interest_list_dto.g.dart';

@JsonSerializable()
class PointOfInterestListDTO {
  const PointOfInterestListDTO(this.points);

  factory PointOfInterestListDTO.fromJson(Map<String, dynamic> json) => _$PointOfInterestListDTOFromJson(json);

  final List<PointOfInterestDTO> points;
}
