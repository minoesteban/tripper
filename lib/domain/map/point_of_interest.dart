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
    this.address,
  });

  final String placeId;
  final String name;
  final Location location;
  final String description;
  final String? imageUrl;
  final double? rating;
  final PointOfInterestType type;
  final String? address;

  @override
  String toString() {
    return 'PointOfInterest(placeId: $placeId, name: $name, location: $location, description: $description, imageUrl: $imageUrl, rating: $rating, type: $type, address: $address)';
  }
}

enum PointOfInterestType { landmark, restaurant }
