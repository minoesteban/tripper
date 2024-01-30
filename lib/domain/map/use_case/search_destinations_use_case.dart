import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/data/map/map_providers.dart';
import 'package:tripper/domain/map/place_autocomplete_result.dart';

part 'search_destinations_use_case.g.dart';

@riverpod
Future<List<PlaceAutocompleteResult>> searchDestionationsUseCase(SearchDestionationsUseCaseRef ref, String text) async {
  final mapRepository = await ref.read(mapRepositoryProvider.future);
  final points = await mapRepository.searchDestinations(text);

  return points;
}
