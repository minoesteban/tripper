import 'package:tripper/data/map/dto/point_of_interest_list_dto.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

abstract class ChatRemoteDataSource {
  Future<PointOfInterestListDTO> getLandmarks(double latitude, double longitude);

  Future<PointOfInterestListDTO> getRestaurants(double latitude, double longitude);

  Future<String> getTripRecommendations(PointOfInterest place, String duration, String people);
}
