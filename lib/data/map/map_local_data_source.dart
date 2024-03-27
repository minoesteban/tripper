import 'package:tripper/domain/map/location.dart';

abstract class MapLocalDataSource {
  Location getPosition();

  Future<void> savePosition(double latitude, double longitude);
}
