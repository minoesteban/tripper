import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/chat/chat_providers.dart';
import 'package:tripper/domain/chat/trip.dart';
import 'package:tripper/domain/map/search_destination_result.dart';

part 'get_trip_recommendations_use_case.g.dart';

@riverpod
Future<Trip> getTripRecommendationsUseCase(
  GetTripRecommendationsUseCaseRef ref,
  SearchDestinationResult destination,
  String duration,
  String people,
) async {
  final chatRepository = await ref.read(chatRepositoryProvider.future);
  final result = await chatRepository.getTripRecommendations(destination, duration, people);

  return result;
}
