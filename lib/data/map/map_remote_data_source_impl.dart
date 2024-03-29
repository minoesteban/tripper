import 'package:flutter_google_maps_webservices/places.dart' as places;
import 'package:tripper/data/map/dto/location_dto.dart';
import 'package:tripper/data/map/dto/place_autocomplete_result_dto.dart';
import 'package:tripper/data/map/dto/place_search_result_dto.dart';
import 'package:tripper/data/map/map_remote_data_source.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  const MapRemoteDataSourceImpl(this.placesClient);

  final places.GoogleMapsPlaces placesClient;

  @override
  Future<List<PlaceSearchResultDTO>> getNearbyLandmarks(double latitude, double longitude) async {
    final result = await placesClient.searchNearbyWithRadius(
      places.Location(lat: latitude, lng: longitude),
      1000,
      type: 'tourist_attraction',
    );

    return _mapSearchResultToDTO(PointOfInterestType.landmark, result);
  }

  @override
  Future<List<PlaceSearchResultDTO>> getNearbyRestaurants(double latitude, double longitude) async {
    final result = await placesClient.searchNearbyWithRadius(
      places.Location(lat: latitude, lng: longitude),
      1000,
      type: 'restaurant',
    );

    return _mapSearchResultToDTO(PointOfInterestType.restaurant, result);
  }

  @override
  Future<List<PlaceAutocompleteResultDTO>> searchDestinations(String text) async {
    final result = await placesClient.autocomplete(
      text,
      types: ['(regions)'],
    );

    return _mapAutocompleteResultToDTO(result);
  }

  Future<List<PlaceSearchResultDTO>> _mapSearchResultToDTO(
      PointOfInterestType type, places.PlacesSearchResponse result) async {
    return result.results.map(
      (place) {
        final photos = place.photos;

        String? imageUrl;
        if (photos.isNotEmpty) {
          final photoReference = place.photos.first.photoReference;
          imageUrl = placesClient.buildPhotoUrl(
            photoReference: photoReference,
            maxWidth: 400,
            maxHeight: 400,
          );
        }

        return PlaceSearchResultDTO(
          type: type,
          placeId: place.placeId,
          name: place.name,
          address: place.formattedAddress,
          description: place.reference,
          imageUrl: imageUrl,
          rating: (place.rating ?? 0.0) * 1.0,
          location: LocationDTO(
            latitude: place.geometry?.location.lat ?? 0,
            longitude: place.geometry?.location.lng ?? 0,
          ),
        );
      },
    ).toList();
  }

  Future<List<PlaceAutocompleteResultDTO>> _mapAutocompleteResultToDTO(places.PlacesAutocompleteResponse result) async {
    return result.predictions
        .where((prediction) => prediction.description != null && prediction.placeId != null)
        .map(
          (prediction) => PlaceAutocompleteResultDTO(
            placeId: prediction.placeId ?? '',
            description: prediction.description!,
          ),
        )
        .toList();
  }
}
