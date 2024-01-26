import 'package:tripper/data/map/map_local_data_source.dart';
import 'package:tripper/data/map/map_repository.dart';
import 'package:tripper/domain/map/location.dart';

class MapRepositoryImpl implements MapRepository {
  const MapRepositoryImpl(this.localDataSource);

  final MapLocalDataSource localDataSource;

  @override
  Location getPosition() => localDataSource.getLocation();

  @override
  Future<void> savePosition(double latitude, double longitude) async {
    return localDataSource.saveLocation(latitude, longitude);
  }
}
