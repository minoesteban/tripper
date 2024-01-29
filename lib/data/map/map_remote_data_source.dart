import 'package:tripper/data/map/dto/place_search_result_dto.dart';

abstract class MapRemoteDataSource {
  Future<List<PlaceSearchResultDTO>> getNearbyLandmarks(double latitude, double longitude);

  Future<List<PlaceSearchResultDTO>> getNearbyRestaurants(double latitude, double longitude);

  Future<List<PlaceSearchResultDTO>> searchDestinations(String text);
}
