import 'package:tripper/domain/map/location.dart';
import 'package:tripper/domain/map/point_of_interest.dart';
import 'package:tripper/domain/map/search_destination_result.dart';

abstract class MapRepository {
  Future<void> savePosition(double latitude, double longitude);

  Location getPosition();

  Future<List<PointOfInterest>> getNearbyLandmarks(double latitude, double longitude);

  Future<List<PointOfInterest>> getNearbyRestaurants(double latitude, double longitude);

  Future<List<SearchDestinationResult>> searchDestinations(String text);
}
