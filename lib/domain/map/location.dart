class Location {
  const Location({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  String toString() => 'Location(latitude: $latitude, longitude: $longitude)';
}
