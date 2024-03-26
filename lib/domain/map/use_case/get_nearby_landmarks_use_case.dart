import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/map/map_providers.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

part 'get_nearby_landmarks_use_case.g.dart';

@riverpod
Future<List<PointOfInterest>> getNearbyLandmarksUseCase(
  GetNearbyLandmarksUseCaseRef ref,
  double latitude,
  double longitude,
) async {
  final mapRepository = await ref.read(mapRepositoryProvider.future);
  final points = await mapRepository.getNearbyLandmarks(latitude, longitude);

  return points;
}
