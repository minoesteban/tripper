import 'package:tripper/domain/map/point_of_interest.dart';

abstract class ChatRepository {
  Future<List<PointOfInterest>> fetchPointsOfInterest(double latitude, double longitude);
}
