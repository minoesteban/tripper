import 'package:tripper/data/map/dto/location_dto.dart';
import 'package:tripper/data/map/dto/place_autocomplete_result_dto.dart';
import 'package:tripper/data/map/dto/place_search_result_dto.dart';
import 'package:tripper/data/map/map_remote_data_source.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

class MapRemoteDataSourceMock implements MapRemoteDataSource {
  @override
  Future<List<PlaceSearchResultDTO>> getNearbyLandmarks(double latitude, double longitude) async {
    return [
      const PlaceSearchResultDTO(
        name: 'Landmark 1',
        address: 'Address 1',
        placeId: '1',
        description: 'Description 1',
        imageUrl: 'https://example.com/image1.jpg',
        rating: 4.5,
        location: LocationDTO(
          latitude: 1.0,
          longitude: 1.0,
        ),
        type: PointOfInterestType.landmark,
      ),
      const PlaceSearchResultDTO(
        name: 'Landmark 2',
        address: 'Address 2',
        placeId: '2',
        description: 'Description 2',
        imageUrl: 'https://example.com/image2.jpg',
        rating: 4.0,
        location: LocationDTO(
          latitude: 2.0,
          longitude: 2.0,
        ),
        type: PointOfInterestType.landmark,
      ),
    ];
  }

  @override
  Future<List<PlaceSearchResultDTO>> getNearbyRestaurants(double latitude, double longitude) async {
    return [
      const PlaceSearchResultDTO(
        name: 'Restaurant 1',
        address: 'Address 1',
        placeId: '1',
        description: 'Description 1',
        imageUrl: 'https://example.com/image1.jpg',
        rating: 4.5,
        location: LocationDTO(
          latitude: 1.0,
          longitude: 1.0,
        ),
        type: PointOfInterestType.restaurant,
      ),
      const PlaceSearchResultDTO(
        name: 'Restaurant 2',
        address: 'Address 2',
        placeId: '2',
        description: 'Description 2',
        imageUrl: 'https://example.com/image2.jpg',
        rating: 4.0,
        location: LocationDTO(
          latitude: 2.0,
          longitude: 2.0,
        ),
        type: PointOfInterestType.restaurant,
      ),
    ];
  }

  @override
  Future<List<PlaceAutocompleteResultDTO>> searchDestinations(String text) async {
    return [
      const PlaceAutocompleteResultDTO(
        placeId: '1',
        description: 'Destination 1',
      ),
      const PlaceAutocompleteResultDTO(
        placeId: '2',
        description: 'Destination 2',
      ),
    ];
  }
}
