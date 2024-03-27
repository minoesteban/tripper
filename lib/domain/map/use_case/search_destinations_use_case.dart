import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/map/map_providers.dart';
import 'package:tripper/domain/map/search_destination_result.dart';

part 'search_destinations_use_case.g.dart';

@riverpod
Future<List<SearchDestinationResult>> searchDestionationsUseCase(SearchDestionationsUseCaseRef ref, String text) async {
  final mapRepository = await ref.read(mapRepositoryProvider.future);
  final points = await mapRepository.searchDestinations(text);

  return points;
}
