import 'package:tripper/domain/map/point_of_interest.dart';

abstract class ChatRepository {
  Future<List<PointOfInterest>> getLandmarks(double latitude, double longitude);

  Future<List<PointOfInterest>> getRestaurants(double latitude, double longitude);

  Future<String> getTripRecommendations(PointOfInterest place, String duration, String people);
}
