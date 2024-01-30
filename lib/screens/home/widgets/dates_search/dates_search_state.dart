import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripper/domain/home/duration_type.dart';
import 'package:tripper/domain/home/period_item.dart';
import 'package:tripper/domain/home/period_type.dart';
import 'package:tripper/l10n/l10n_utils.dart';
import 'package:tripper/screens/home/utils/period_item_utils.dart';
import 'package:tripper/screens/utils/dates_utils.dart';

part 'dates_search_state.freezed.dart';

@freezed
class DatesSearchState with _$DatesSearchState {
  const DatesSearchState._();

  const factory DatesSearchState.init() = _DatesSearchStateInit;

  const factory DatesSearchState.dates({
    required DateTime fromDate,
    required DateTime toDate,
  }) = _DatesSearchStateDates;

  const factory DatesSearchState.period({
    required DurationType durationType,
    required int duration,
    required PeriodType periodType,
    required Set<PeriodItem> periodItems,
  }) = _DatesSearchStatePeriod;

  const factory DatesSearchState.error(String message) = _DatesSearchStateError;

  String get description => maybeWhen(
        dates: (fromDate, toDate) => '${fromDate.asDateLong} to ${toDate.asDateLong}',
        period: (durationType, duration, periodType, periodItems) =>
            '$duration ${durationType.name} in ${periodItems.map((item) => item.name).join(', ')}',
        orElse: () => '',
      );
}

extension on DurationType {
  String get name {
    switch (this) {
      case DurationType.days:
        return L10n.current.home_date_days;
      case DurationType.weeks:
        return L10n.current.home_date_weeks;
      case DurationType.months:
        return L10n.current.home_date_months;
    }
  }
}
