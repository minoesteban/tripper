import 'package:tripper/domain/map/location.dart';

class PointOfInterest {
  const PointOfInterest({
    required this.placeId,
    required this.name,
    required this.description,
    required this.location,
    required this.type,
    this.rating,
    this.imageUrl,
  });

  final String placeId;
  final String name;
  final Location location;
  final String description;
  final String? imageUrl;
  final double? rating;
  final PointOfInterestType type;
}

enum PointOfInterestType { landmark, restaurant }
