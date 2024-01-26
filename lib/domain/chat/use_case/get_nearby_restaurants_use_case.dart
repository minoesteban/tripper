import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/map/map_providers.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

part 'get_nearby_restaurants_use_case.g.dart';

@riverpod
Future<List<PointOfInterest>> getNearbyRestaurantsUseCase(
  GetNearbyRestaurantsUseCaseRef ref,
  double latitude,
  double longitude,
) async {
  final mapRepository = await ref.read(mapRepositoryProvider.future);
  final points = await mapRepository.getNearbyRestaurants(latitude, longitude);

  return points;
}
