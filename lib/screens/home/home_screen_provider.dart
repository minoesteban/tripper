import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/chat/use_case/get_trip_recommendations_use_case.dart';
import 'package:tripper/screens/home/home_state.dart';
import 'package:tripper/screens/home/widgets/dates_search/dates_search_provider.dart';
import 'package:tripper/screens/home/widgets/people_search/people_search_provider.dart';
import 'package:tripper/screens/home/widgets/places_search/places_search_provider.dart';

part 'home_screen_provider.g.dart';

@riverpod
class HomeScreenNotifier extends _$HomeScreenNotifier {
  @override
  Future<HomeState> build() async => const HomeState.init();

  Future<void> triggerSearch() async {
    final placeSearchState = await ref.watch(placesSearchNotifierProvider.future);
    final datesSearchState = await ref.watch(datesSearchNotifierProvider.future);
    final peopleSearchState = await ref.watch(peopleSearchNotifierProvider.future);

    final selectedPlace = placeSearchState.mapOrNull(
      selected: (value) => value.place,
    );

    final selectedDates = datesSearchState.mapOrNull(
      dates: (value) => value.description,
      period: (value) => value.description,
    );

    final selectedPeople = peopleSearchState.mapOrNull(
      set: (value) => value.description,
    );

    if (selectedPlace == null) {
      state = const AsyncValue.data(
        HomeState.error('Please select a destination'),
      );
      return;
    }

    if (selectedDates == null) {
      state = const AsyncValue.data(
        HomeState.error('Please select dates or a period of time'),
      );
      return;
    }

    if (selectedPeople == null) {
      state = const AsyncValue.data(
        HomeState.error('Please select the number of travellers'),
      );
      return;
    }

    try {
      state = const AsyncValue.loading();
      final result = await ref.read(
        getTripRecommendationsUseCaseProvider(
          selectedPlace,
          selectedDates,
          selectedPeople,
        ).future,
      );

      state = AsyncValue.data(
        HomeState.result(result),
      );
    } catch (e) {
      state = const AsyncValue.data(
        HomeState.error('Something went wrong'),
      );

      state = const AsyncValue.data(HomeState.init());
    }
  }
}
