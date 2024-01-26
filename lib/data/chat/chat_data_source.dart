import 'package:tripper/data/map/dto/point_of_interest_list_dto.dart';

abstract class ChatDataSource {
  Future<PointOfInterestListDTO> fetchPointsOfInterest(double latitude, double longitude);
}
