import 'package:intl/intl.dart';
import 'package:tripper/domain/home/period_item.dart';
import 'package:tripper/domain/home/period_type.dart';
import 'package:tripper/l10n/generated/l10n.dart';

extension PeriodItemExtension on PeriodItem {
  String get name {
    switch (type) {
      case PeriodType.month:
        return DateFormat.LLLL().format(DateTime(0, value));
      case PeriodType.season:
        switch (value) {
          case 1:
            return L10n.current.common_season_winter;
          case 2:
            return L10n.current.common_season_spring;
          case 3:
            return L10n.current.common_season_summer;
          case 4:
            return L10n.current.common_season_autumn;
          default:
            throw UnimplementedError('Unknown season value: $value');
        }
    }
  }
}
