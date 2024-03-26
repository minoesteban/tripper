import 'package:tripper/domain/chat/trip.dart';
import 'package:tripper/domain/map/place_autocomplete_result.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

abstract class ChatRepository {
  Future<List<PointOfInterest>> getLandmarks(double latitude, double longitude);

  Future<List<PointOfInterest>> getRestaurants(double latitude, double longitude);

  Future<Trip> getTripRecommendations(PlaceAutocompleteResult place, String duration, String people);
}
