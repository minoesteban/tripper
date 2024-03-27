import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/map/search_destination_result.dart';
import 'package:tripper/domain/map/use_case/search_destinations_use_case.dart';
import 'package:tripper/screens/home/widgets/places_search/places_search_state.dart';
import 'package:tripper/utils/debouncer.dart';

part 'places_search_provider.g.dart';

const searchDebounceTime = Duration(milliseconds: 500);

@riverpod
class PlacesSearchNotifier extends _$PlacesSearchNotifier {
  final _debouncer = Debouncer(searchDebounceTime);

  @override
  Future<PlacesSearchState> build() async => const PlacesSearchState.init();

  Future<void> search(String query) async {
    if (query.isEmpty) return;

    if (query.length < 3) return;

    _debouncer.run(() async {
      state = const AsyncValue.loading();

      final results = await ref.read(searchDestionationsUseCaseProvider(query).future);

      log('Results: ${results.map((e) => e.description)}');

      state = AsyncValue.data(
        PlacesSearchState.idle(results),
      );
    });
  }

  void selectPlace(SearchDestinationResult place) {
    state = AsyncValue.data(
      PlacesSearchState.selected(place),
    );
  }
}
