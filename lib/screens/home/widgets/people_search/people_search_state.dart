import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/l10n/l10n_utils.dart';

part 'people_search_state.freezed.dart';

@freezed
class PeopleSearchState with _$PeopleSearchState {
  const PeopleSearchState._();

  const factory PeopleSearchState.init() = _PeopleSearchStateInit;

  const factory PeopleSearchState.set({
    required int numberOfAdults,
    required int numberOfChildren,
    required int numberOfInfants,
  }) = _PeopleSearchStateSet;

  const factory PeopleSearchState.error(String message) = _PeopleSearchStateError;

  String get description => when(
        init: () => '',
        set: (numberOfAdults, numberOfChildren, numberOfInfants) {
          String title = '';

          if (numberOfAdults > 0) title = L10n.current.home_people_adults_count(numberOfAdults);

          if (numberOfChildren > 0) {
            title += '${title.isNotEmpty ? ', ' : ''}${L10n.current.home_people_children_count(numberOfChildren)}';
          }

          if (numberOfInfants > 0) {
            title += '${title.isNotEmpty ? ', ' : ''}${L10n.current.home_people_infants_count(numberOfInfants)}';
          }

          return title;
        },
        error: (message) => message,
      );
}
