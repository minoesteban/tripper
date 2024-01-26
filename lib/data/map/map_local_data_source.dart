import 'package:tripper/domain/map/location.dart';

abstract class MapLocalDataSource {
  Location getLocation();

  Future<void> saveLocation(double latitude, double longitude);
}
