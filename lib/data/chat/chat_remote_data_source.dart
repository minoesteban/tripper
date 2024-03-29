import 'package:tripper/data/chat/dto/trip_dto.dart';
import 'package:tripper/data/map/dto/point_of_interest_list_dto.dart';
import 'package:tripper/domain/map/search_destination_result.dart';

abstract class ChatRemoteDataSource {
  Future<PointOfInterestListDTO> getLandmarks(double latitude, double longitude);

  Future<PointOfInterestListDTO> getRestaurants(double latitude, double longitude);

  Future<TripDTO> getTripRecommendations(SearchDestinationResult place, String duration, String people);
}
