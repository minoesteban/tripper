import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripper/data/map/exceptions.dart';
import 'package:tripper/data/map/map_local_data_source.dart';
import 'package:tripper/domain/map/location.dart';

const _locationLatitudeKey = 'location-latitude';
const _locationLongitudeKey = 'location-longitude';

class MapLocalDataSourceImpl implements MapLocalDataSource {
  const MapLocalDataSourceImpl(this.storage);

  final SharedPreferences storage;

  @override
  Location getPosition() {
    final latitude = storage.getDouble(_locationLatitudeKey);
    final longitude = storage.getDouble(_locationLongitudeKey);

    if (latitude == null || longitude == null) {
      throw LocationNotAvailableException();
    }

    return Location(
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<void> savePosition(double latitude, double longitude) async {
    await storage.setDouble(_locationLatitudeKey, latitude);
    await storage.setDouble(_locationLongitudeKey, longitude);
  }
}
