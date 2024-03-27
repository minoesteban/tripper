import 'package:tripper/data/chat/chat_remote_data_source.dart';
import 'package:tripper/data/chat/dto/trip_dto.dart';
import 'package:tripper/data/map/dto/location_dto.dart';
import 'package:tripper/data/map/dto/point_of_interest_dto.dart';
import 'package:tripper/data/map/dto/point_of_interest_list_dto.dart';
import 'package:tripper/domain/map/point_of_interest.dart';
import 'package:tripper/domain/map/search_destination_result.dart';
import 'package:tripper/mocks/mock_data.dart';

class ChatRemoteDataSourceMock implements ChatRemoteDataSource {
  @override
  Future<PointOfInterestListDTO> getLandmarks(double latitude, double longitude) async {
    return PointOfInterestListDTO(
      [
        PointOfInterestDTO(
          name: 'Landmark 1',
          placeId: '1',
          description: 'Description 1',
          imageUrl: 'https://example.com/image1.jpg',
          rating: 4.5,
          location: const LocationDTO(
            latitude: 1.0,
            longitude: 1.0,
          ),
          type: PointOfInterestType.landmark,
        ),
        PointOfInterestDTO(
          name: 'Landmark 2',
          placeId: '2',
          description: 'Description 2',
          imageUrl: 'https://example.com/image2.jpg',
          rating: 4.0,
          location: const LocationDTO(
            latitude: 2.0,
            longitude: 2.0,
          ),
          type: PointOfInterestType.landmark,
        ),
      ],
    );
  }

  @override
  Future<PointOfInterestListDTO> getRestaurants(double latitude, double longitude) async {
    return PointOfInterestListDTO(
      [
        PointOfInterestDTO(
          name: 'Restaurant 1',
          placeId: '1',
          description: 'Description 1',
          imageUrl: 'https://example.com/image1.jpg',
          rating: 4.5,
          location: const LocationDTO(
            latitude: 1.0,
            longitude: 1.0,
          ),
          type: PointOfInterestType.restaurant,
        ),
        PointOfInterestDTO(
          name: 'Restaurant 2',
          placeId: '2',
          description: 'Description 2',
          imageUrl: 'https://example.com/image2.jpg',
          rating: 4.0,
          location: const LocationDTO(
            latitude: 2.0,
            longitude: 2.0,
          ),
          type: PointOfInterestType.restaurant,
        ),
      ],
    );
  }

  @override
  Future<TripDTO> getTripRecommendations(SearchDestinationResult place, String duration, String people) async {
    final json = MockData.mockTripPromptResponse as Map<String, dynamic>;
    return TripDTO.fromJson(json['trip'] as Map<String, dynamic>);
  }
}
