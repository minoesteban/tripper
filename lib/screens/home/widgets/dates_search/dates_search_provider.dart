import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tripper/domain/home/duration_type.dart';
import 'package:tripper/domain/home/period_item.dart';
import 'package:tripper/domain/home/period_type.dart';
import 'package:tripper/screens/home/widgets/dates_search/dates_search_state.dart';

part 'dates_search_provider.g.dart';

@riverpod
class DatesSearchNotifier extends _$DatesSearchNotifier {
  @override
  Future<DatesSearchState> build() async => const DatesSearchState.init();

  void setDates(DateTime from, DateTime to) {
    state = AsyncValue.data(
      DatesSearchState.dates(
        fromDate: from,
        toDate: to,
      ),
    );
  }

  void setPeriod(
    DurationType durationType,
    int duration,
    PeriodType periodType,
    Set<PeriodItem> periodItems,
  ) {
    if (periodItems.isEmpty) {
      state = const AsyncValue.data(DatesSearchState.error(
        'Please select at least one period',
      ));
      return;
    }
    state = AsyncValue.data(
      DatesSearchState.period(
        durationType: durationType,
        duration: duration,
        periodType: periodType,
        periodItems: periodItems,
      ),
    );
  }
}
