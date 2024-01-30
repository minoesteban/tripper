import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/chat/chat_providers.dart';
import 'package:tripper/domain/map/place_autocomplete_result.dart';

part 'get_trip_recommendations_use_case.g.dart';

@riverpod
Future<String> getTripRecommendationsUseCase(
  GetTripRecommendationsUseCaseRef ref,
  PlaceAutocompleteResult place,
  String duration,
  String people,
) async {
  final chatRepository = await ref.read(chatRepositoryProvider.future);
  final result = await chatRepository.getTripRecommendations(place, duration, people);

  return result;
}
