import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/chat/chat_providers.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

part 'get_points_of_interest_use_case.g.dart';

@riverpod
Future<List<PointOfInterest>> getPointsOfInterestUseCase(
  GetPointsOfInterestUseCaseRef ref,
  double latitude,
  double longitude,
) async {
  final repository = await ref.read(chatRepositoryProvider.future);
  final points = await repository.fetchPointsOfInterest(latitude, longitude);

  return points;
}
