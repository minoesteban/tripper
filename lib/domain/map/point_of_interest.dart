import 'package:tripper/domain/map/location.dart';

class PointOfInterest {
  PointOfInterest({
    required this.placeId,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.location,
  });

  final String placeId;
  final String name;
  final String description;
  final String image;
  final double rating;
  final Location location;
}
