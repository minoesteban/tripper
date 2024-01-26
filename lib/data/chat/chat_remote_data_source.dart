import 'package:tripper/data/map/dto/point_of_interest_list_dto.dart';

abstract class ChatRemoteDataSource {
  Future<PointOfInterestListDTO> getLandmarks(double latitude, double longitude);

  Future<PointOfInterestListDTO> getRestaurants(double latitude, double longitude);
}
