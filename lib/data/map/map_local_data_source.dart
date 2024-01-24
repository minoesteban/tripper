import 'package:tripper/domain/map/location.dart';

abstract class MapLocalDataSource {
  Future<void> savePosition(double latitude, double longitude);

  Location getPosition();
}
