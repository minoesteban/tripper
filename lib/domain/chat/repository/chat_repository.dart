import 'package:tripper/domain/chat/trip.dart';
import 'package:tripper/domain/map/point_of_interest.dart';
import 'package:tripper/domain/map/search_destination_result.dart';

abstract class ChatRepository {
  Future<List<PointOfInterest>> getLandmarks(double latitude, double longitude);

  Future<List<PointOfInterest>> getRestaurants(double latitude, double longitude);

  Future<Trip> getTripRecommendations(SearchDestinationResult place, String duration, String people);
}
