import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/map/use_case/search_destinations_use_case.dart';
import 'package:tripper/screens/home/widgets/places_search/places_search_state.dart';
import 'package:tripper/utils/debouncer.dart';

part 'places_search_provider.g.dart';

const searchDebounceTime = Duration(milliseconds: 2000);

@riverpod
class PlacesSearchNotifier extends _$PlacesSearchNotifier {
  final _debouncer = Debouncer(searchDebounceTime);

  @override
  Future<PlacesSearchState> build() async => const PlacesSearchState.init();

  Future<void> search(String query) async {
    if (query.isEmpty) return;

    _debouncer.run(() async {
      state = const AsyncValue.loading();

      final results = await ref.read(searchDestionationsUseCaseProvider(query).future);

      log('Results: ${results.map((e) => e.name)}');

      state = AsyncValue.data(
        PlacesSearchState.idle(results),
      );
    });

    // void selectPlace(PointOfInterest place) {
    //   state = AsyncValue.data(
    //     PlacesSearchState.selected(place),
    //   );
    // }
  }
}
