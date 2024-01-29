import 'package:tripper/data/map/map_local_data_source.dart';
import 'package:tripper/data/map/map_remote_data_source.dart';
import 'package:tripper/data/map/map_repository.dart';
import 'package:tripper/data/map/mapper/place_search_result_dto_mapper.dart';
import 'package:tripper/domain/map/location.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

class MapRepositoryImpl implements MapRepository {
  const MapRepositoryImpl({required this.localDataSource, required this.remoteDataSource});

  final MapLocalDataSource localDataSource;
  final MapRemoteDataSource remoteDataSource;

  PlaceSearchResultDTOMapper get placeSearchResultDTOMapper => const PlaceSearchResultDTOMapper();

  @override
  Location getPosition() => localDataSource.getLocation();

  @override
  Future<void> savePosition(double latitude, double longitude) async {
    return localDataSource.saveLocation(latitude, longitude);
  }

  @override
  Future<List<PointOfInterest>> getNearbyLandmarks(double latitude, double longitude) async {
    final dto = await remoteDataSource.getNearbyLandmarks(latitude, longitude);
    return dto.map(placeSearchResultDTOMapper.to).toList();
  }

  @override
  Future<List<PointOfInterest>> getNearbyRestaurants(double latitude, double longitude) async {
    final dto = await remoteDataSource.getNearbyRestaurants(latitude, longitude);
    return dto.map(placeSearchResultDTOMapper.to).toList();
  }

  @override
  Future<List<PointOfInterest>> searchDestinations(String text) async {
    final dto = await remoteDataSource.searchDestinations(text);
    return dto.map(placeSearchResultDTOMapper.to).toList();
  }
}
