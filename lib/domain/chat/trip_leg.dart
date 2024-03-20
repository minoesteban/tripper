class TripLeg {
  const TripLeg({
    required this.title,
    required this.imageUrl,
    required this.fromDate,
    required this.toDate,
    required this.places,
    required this.activities,
  });

  final String title;
  final String imageUrl;
  final DateTime fromDate;
  final DateTime toDate;
  final List<String> places;
  final List<String> activities;

  @override
  String toString() =>
      'TripLeg(title: $title, imageUrl: $imageUrl, fromDate: $fromDate, toDate: $toDate, places: $places, activities: $activities)';
}
