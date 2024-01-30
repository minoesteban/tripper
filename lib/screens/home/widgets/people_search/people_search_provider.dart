import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/screens/home/widgets/people_search/people_search_state.dart';

part 'people_search_provider.g.dart';

@riverpod
class PeopleSearchNotifier extends _$PeopleSearchNotifier {
  @override
  Future<PeopleSearchState> build() async => const PeopleSearchState.init();

  void setPeople(int adults, int children, int infants) {
    if (adults == 0 && children == 0 && infants == 0) {
      state = const AsyncValue.data(PeopleSearchState.error(
        'Please set at least one traveller',
      ));

      return;
    }

    state = AsyncValue.data(
      PeopleSearchState.set(
        numberOfAdults: adults,
        numberOfChildren: children,
        numberOfInfants: infants,
      ),
    );
  }
}
