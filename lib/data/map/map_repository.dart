import 'package:tripper/domain/map/location.dart';

abstract class MapRepository {
  Future<void> savePosition(double latitude, double longitude);

  Location getPosition();
}
