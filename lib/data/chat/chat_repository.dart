import 'package:tripper/domain/map/place_autocomplete_result.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

abstract class ChatRepository {
  Future<List<PointOfInterest>> getLandmarks(double latitude, double longitude);

  Future<List<PointOfInterest>> getRestaurants(double latitude, double longitude);

  Future<String> getTripRecommendations(PlaceAutocompleteResult place, String duration, String people);
}
