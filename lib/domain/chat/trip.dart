import 'package:tripper/domain/chat/trip_leg.dart';

class Trip {
  const Trip({
    required this.name,
    required this.imageUrl,
    required this.legs,
  });

  final String name;
  final String imageUrl;
  final List<TripLeg> legs;

  @override
  String toString() => 'Trip(name: $name, imageUrl: $imageUrl, legs: $legs)';
}
