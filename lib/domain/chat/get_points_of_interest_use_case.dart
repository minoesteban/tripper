import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/chat/chat_providers.dart';

part 'get_points_of_interest_use_case.g.dart';

@riverpod
Future<String> getPointsOfInterestUseCase(GetPointsOfInterestUseCaseRef ref, double latitude, double longitude) {
  final repository = ref.read(chatRepositoryProvider);

  return repository.fetchPointsOfInterest(latitude, longitude);
}
