import 'package:tripper/data/chat/chat_remote_data_source.dart';
import 'package:tripper/data/chat/chat_repository.dart';
import 'package:tripper/data/chat/mapper/trip_dto_mapper.dart';
import 'package:tripper/data/map/mapper/point_of_interest_dto_mapper.dart';
import 'package:tripper/domain/chat/trip.dart';
import 'package:tripper/domain/map/place_autocomplete_result.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._dataSource);

  final ChatRemoteDataSource _dataSource;

  PointOfInterestDTOMapper get pointOfInterestDTOMapper => const PointOfInterestDTOMapper();
  TripDTOMapper get tripDTOMapper => const TripDTOMapper();

  @override
  Future<List<PointOfInterest>> getLandmarks(double latitude, double longitude) async {
    final dto = await _dataSource.getLandmarks(latitude, longitude);
    return dto.points.map(pointOfInterestDTOMapper.to).toList();
  }

  @override
  Future<List<PointOfInterest>> getRestaurants(double latitude, double longitude) async {
    final dto = await _dataSource.getRestaurants(latitude, longitude);
    return dto.points.map(pointOfInterestDTOMapper.to).toList();
  }

  @override
  Future<Trip> getTripRecommendations(PlaceAutocompleteResult place, String duration, String people) async {
    final dto = await _dataSource.getTripRecommendations(place, duration, people);
    return tripDTOMapper.to(dto);
  }
}
